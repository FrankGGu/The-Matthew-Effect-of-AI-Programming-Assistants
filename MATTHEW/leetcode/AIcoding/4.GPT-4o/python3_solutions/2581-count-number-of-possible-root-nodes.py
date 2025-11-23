class Solution:
    def countRootNodes(self, edges: List[List[int]]) -> int:
        from collections import defaultdict

        indegree = defaultdict(int)

        for u, v in edges:
            indegree[v] += 1

        return sum(1 for node in indegree if indegree[node] == 0) + (len(edges) + 1 - len(indegree))