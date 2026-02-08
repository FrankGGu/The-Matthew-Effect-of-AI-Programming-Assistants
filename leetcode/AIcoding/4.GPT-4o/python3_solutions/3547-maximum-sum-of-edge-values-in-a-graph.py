class Solution:
    def maximalEdgeSum(self, edges: List[List[int]], values: List[int]) -> int:
        graph = defaultdict(list)
        for u, v in edges:
            graph[u].append(v)
            graph[v].append(u)

        max_sum = 0
        visited = set()

        def dfs(node, current_sum):
            nonlocal max_sum
            visited.add(node)
            current_sum += values[node]
            max_sum = max(max_sum, current_sum)
            for neighbor in graph[node]:
                if neighbor not in visited:
                    dfs(neighbor, current_sum)
            visited.remove(node)

        for i in range(len(values)):
            if i not in visited:
                dfs(i, 0)

        return max_sum