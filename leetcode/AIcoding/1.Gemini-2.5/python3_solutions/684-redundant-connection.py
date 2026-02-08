from typing import List

class Solution:
    def findRedundantConnection(self, edges: List[List[int]]) -> List[int]:
        max_node = 0
        for u, v in edges:
            max_node = max(max_node, u, v)

        parent = list(range(max_node + 1))

        def find(i):
            if parent[i] == i:
                return i
            parent[i] = find(parent[i])
            return parent[i]

        def union(i, j):
            root_i = find(i)
            root_j = find(j)
            if root_i != root_j:
                parent[root_i] = root_j
                return False
            return True

        for u, v in edges:
            if union(u, v):
                return [u, v]

        return []