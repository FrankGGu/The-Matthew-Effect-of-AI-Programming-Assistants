class Solution:
    def gcdTraversal(self, nums: List[int]) -> bool:
        from collections import deque
        from math import gcd

        n = len(nums)
        graph = [[] for _ in range(n)]

        for i in range(n):
            for j in range(i + 1, n):
                if gcd(nums[i], nums[j]) > 1:
                    graph[i].append(j)
                    graph[j].append(i)

        visited = [False] * n
        queue = deque([0])
        visited[0] = True

        while queue:
            node = queue.popleft()
            for neighbor in graph[node]:
                if not visited[neighbor]:
                    visited[neighbor] = True
                    queue.append(neighbor)

        return all(visited)