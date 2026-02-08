class Solution:
    def minEdgeWeightEquilibriumQueries(self, n: int, edges: List[List[int]], queries: List[List[int]]) -> List[int]:
        from collections import defaultdict

        graph = defaultdict(list)
        for u, v, w in edges:
            graph[u].append((v, w))
            graph[v].append((u, w))

        def dfs(node, parent):
            weights = []
            for neighbor, weight in graph[node]:
                if neighbor != parent:
                    weights.append(dfs(neighbor, node) + [weight])
            if not weights:
                return [float('inf')]
            return sorted((min(w) for w in zip(*weights)), reverse=True)

        min_weights = dfs(1, -1)
        result = []
        for x, y in queries:
            if x == y:
                result.append(0)
            else:
                result.append(min(min_weights[min(x, y) - 1], min_weights[max(x, y) - 1]))
        return result