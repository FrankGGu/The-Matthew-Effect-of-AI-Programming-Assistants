from collections import defaultdict

class Solution:
    def minimumTime(self, n: int, edges: list[list[int]], nodes: list[int]) -> int:
        adj = defaultdict(list)
        for u, v in edges:
            adj[u - 1].append(v - 1)
            adj[v - 1].append(u - 1)

        time = [float('inf')] * n
        time[0] = 0

        q = [(0, 0)]
        visited = {0}

        while q:
            u, t = q.pop(0)

            decay = nodes[u]

            for v in adj[u]:
                if v not in visited:
                    visited.add(v)
                    new_time = t + 1
                    if new_time % 2 == 0 and decay == 1:
                        new_time += 1

                    time[v] = new_time
                    q.append((v, new_time))

        return time[n-1]