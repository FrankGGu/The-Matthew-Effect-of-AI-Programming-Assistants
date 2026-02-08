class Solution:
    def minimumScore(self, nums: List[int], edges: List[List[int]]) -> int:
        from collections import defaultdict

        graph = defaultdict(list)
        for u, v in edges:
            graph[u].append(v)
            graph[v].append(u)

        n = len(nums)
        visited = [False] * n
        min_score = float('inf')

        def dfs(node):
            nonlocal min_score
            visited[node] = True
            current_min = nums[node]
            for neighbor in graph[node]:
                if not visited[neighbor]:
                    current_min = min(current_min, dfs(neighbor))
            min_score = min(min_score, current_min)
            return current_min

        dfs(0)

        return min_score