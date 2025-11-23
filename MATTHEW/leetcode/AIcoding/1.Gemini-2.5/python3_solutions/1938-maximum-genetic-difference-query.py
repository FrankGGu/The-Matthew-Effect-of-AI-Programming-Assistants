class TrieNode:
    def __init__(self):
        self.children = [None, None]
        self.count = 0

class Trie:
    def __init__(self, max_bits=30):
        self.root = TrieNode()
        self.max_bits = max_bits

    def insert(self, num):
        curr = self.root
        for i in range(self.max_bits - 1, -1, -1):
            bit = (num >> i) & 1
            if curr.children[bit] is None:
                curr.children[bit] = TrieNode()
            curr = curr.children[bit]
            curr.count += 1

    def remove(self, num):
        curr = self.root
        for i in range(self.max_bits - 1, -1, -1):
            bit = (num >> i) & 1
            curr = curr.children[bit]
            curr.count -= 1

    def query(self, val):
        curr = self.root
        max_xor_val = 0
        for i in range(self.max_bits - 1, -1, -1):
            bit = (val >> i) & 1
            opposite_bit = 1 - bit
            if curr.children[opposite_bit] is not None and curr.children[opposite_bit].count > 0:
                max_xor_val |= (1 << i)
                curr = curr.children[opposite_bit]
            else:
                # If opposite_bit path doesn't exist or is empty, take the same_bit path
                # This path must exist if the number was inserted and not fully removed
                # (i.e., curr.count > 0 for some path).
                # If curr.children[bit] is None, it implies an error or no numbers are left
                # passing through this path, which should be caught by count check earlier.
                # Since we only query for numbers that are guaranteed to be in the trie (or their path),
                # curr.children[bit] should not be None here if curr.count > 0.
                curr = curr.children[bit]
        return max_xor_val

class Solution:
    def maxGeneticDifference(self, parents: list[int], nums: list[int], queries: list[list[int]]) -> list[int]:
        n = len(parents)
        adj = [[] for _ in range(n)]
        root = -1
        for i in range(n):
            if parents[i] == -1:
                root = i
            else:
                adj[parents[i]].append(i)

        queries_at_node = [[] for _ in range(n)]
        for i, (node, val) in enumerate(queries):
            queries_at_node[node].append((val, i))

        ans = [0] * len(queries)
        trie = Trie()

        subtree_size = [0] * n
        def compute_subtree_sizes(u):
            subtree_size[u] = 1
            for v_child in adj[u]:
                subtree_size[u] += compute_subtree_sizes(v_child)
            return subtree_size[u]

        compute_subtree_sizes(root)

        def add_subtree_to_trie_recursive(u_node):
            trie.insert(nums[u_node])
            for v_child in adj[u_node]:
                add_subtree_to_trie_recursive(v_child)

        def remove_subtree_from_trie_recursive(u_node):
            trie.remove(nums[u_node])
            for v_child in adj[u_node]:
                remove_subtree_from_trie_recursive(v_child)

        def dfs_dsu_on_tree(u, keep):
            heavy_child = -1
            max_size = -1
            for v_child in adj[u]:
                if subtree_size[v_child] > max_size:
                    max_size = subtree_size[v_child]
                    heavy_child = v_child

            for v_child in adj[u]:
                if v_child != heavy_child:
                    dfs_dsu_on_tree(v_child, False)

            if heavy_child != -1:
                dfs_dsu_on_tree(heavy_child, True)

            trie.insert(nums[u])

            for v_child in adj[u]:
                if v_child != heavy_child:
                    add_subtree_to_trie_recursive(v_child)

            for val, idx in queries_at_node[u]:
                ans[idx] = trie.query(val)

            if not keep:
                remove_subtree_from_trie_recursive(u)

        dfs_dsu_on_tree(root, False)
        return ans