class TrieNode:
    def __init__(self):
        self.children = [None] * 2
        self.val = 0

class Solution:
    def maxGeneticDifference(self, parents: List[int], queries: List[List[int]]) -> List[int]:
        n = len(parents)
        children = [[] for _ in range(n)]
        root = -1
        for i in range(n):
            if parents[i] == -1:
                root = i
            else:
                children[parents[i]].append(i)

        trie_root = TrieNode()

        def insert(num):
            node = trie_root
            for i in range(17, -1, -1):
                bit = (num >> i) & 1
                if not node.children[bit]:
                    node.children[bit] = TrieNode()
                node = node.children[bit]
            node.val = num

        def query(num):
            node = trie_root
            for i in range(17, -1, -1):
                bit = (num >> i) & 1
                if node.children[1 - bit]:
                    node = node.children[1 - bit]
                else:
                    node = node.children[bit]
            return node.val ^ num

        def remove(num):
            node = trie_root
            for i in range(17, -1, -1):
                bit = (num >> i) & 1
                node = node.children[bit]
            node.val = 0

        q = [[] for _ in range(n)]
        for i, (node, val) in enumerate(queries):
            q[node].append((i, val))

        ans = [0] * len(queries)

        def dfs(node):
            insert(node_val[node])
            for i, val in q[node]:
                ans[i] = query(val)
            for child in children[node]:
                dfs(child)
            remove(node_val[node])

        node_val = [0] * n
        node_val[root] = 0

        stack = [(root, 0)]
        visited = [False] * n
        while stack:
            node, val = stack.pop()
            node_val[node] = val
            visited[node] = True
            for child in children[node]:
                stack.append((child, val))

        dfs(root)
        return ans