class TrieNode:
    def __init__(self):
        self.children = {}
        self.count = 0

class Solution:
    def maxGeneticDifference(self, parents: List[int], queries: List[List[int]]) -> List[int]:
        n = len(parents)
        root = -1
        children = defaultdict(list)
        for i in range(n):
            if parents[i] == -1:
                root = i
            else:
                children[parents[i]].append(i)

        query_dict = defaultdict(list)
        for idx, (node, val) in enumerate(queries):
            query_dict[node].append((val, idx))

        res = [0] * len(queries)
        trie_root = TrieNode()

        def dfs(node):
            add_to_trie(node)
            for val, idx in query_dict.get(node, []):
                res[idx] = find_max_xor(val)
            for child in children[node]:
                dfs(child)
            remove_from_trie(node)

        def add_to_trie(num):
            node = trie_root
            for i in range(17, -1, -1):
                bit = (num >> i) & 1
                if bit not in node.children:
                    node.children[bit] = TrieNode()
                node = node.children[bit]
                node.count += 1

        def remove_from_trie(num):
            node = trie_root
            for i in range(17, -1, -1):
                bit = (num >> i) & 1
                node = node.children[bit]
                node.count -= 1

        def find_max_xor(num):
            node = trie_root
            max_xor = 0
            for i in range(17, -1, -1):
                bit = (num >> i) & 1
                toggled_bit = 1 - bit
                if toggled_bit in node.children and node.children[toggled_bit].count > 0:
                    max_xor ^= (1 << i)
                    node = node.children[toggled_bit]
                else:
                    node = node.children[bit]
            return max_xor

        dfs(root)
        return res