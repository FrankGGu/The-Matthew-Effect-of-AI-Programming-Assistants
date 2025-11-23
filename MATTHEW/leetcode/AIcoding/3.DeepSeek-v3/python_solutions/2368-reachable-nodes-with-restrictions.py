class Solution:
    def reachableNodes(self, n: int, edges: List[List[int]], restricted: List[int]) -> int:
        restricted_set = set(restricted)
        graph = [[] for _ in range(n)]
        for u, v in edges:
            if u not in restricted_set and v not in restricted_set:
                graph[u].append(v)
                graph[v].append(u)

        visited = [False] * n
        stack = [0]
        visited[0] = True
        count = 0

        while stack:
            node = stack.pop()
            count += 1
            for neighbor in graph[node]:
                if not visited[neighbor]:
                    visited[neighbor] = True
                    stack.append(neighbor)

        return count