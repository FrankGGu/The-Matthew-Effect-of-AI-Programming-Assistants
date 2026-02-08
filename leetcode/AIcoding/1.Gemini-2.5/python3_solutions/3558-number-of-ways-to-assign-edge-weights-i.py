import collections

class Solution:
    def numberOfWays(self, n: int, edges: list[list[int]]) -> int:
        adj = collections.defaultdict(list)
        for u, v in edges:
            adj[u].append(v)
            adj[v].append(u)

        visited = [False] * n
        num_components = 0

        for i in range(n):
            if not visited[i]:
                num_components += 1

                q = collections.deque([i])
                visited[i] = True
                while q:
                    node = q.popleft()
                    for neighbor in adj[node]:
                        if not visited[neighbor]:
                            visited[neighbor] = True
                            q.append(neighbor)

        if num_components > 6:
            return 0

        result = 1
        for i in range(num_components):
            result *= (6 - i)

        return result