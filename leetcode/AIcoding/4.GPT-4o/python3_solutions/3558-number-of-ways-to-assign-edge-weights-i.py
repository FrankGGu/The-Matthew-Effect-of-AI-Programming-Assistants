class Solution:
    def waysToAssignWeights(self, n: int, edges: List[List[int]]) -> int:
        MOD = 10**9 + 7
        from collections import defaultdict
        graph = defaultdict(list)
        for u, v in edges:
            graph[u].append(v)
            graph[v].append(u)

        def dfs(node, parent):
            total_ways = 1
            children_count = 0
            for neighbor in graph[node]:
                if neighbor != parent:
                    child_ways, child_count = dfs(neighbor, node)
                    total_ways = (total_ways * child_ways) % MOD
                    children_count += child_count
            return total_ways, children_count + 1

        total_ways, _ = dfs(1, -1)
        return total_ways