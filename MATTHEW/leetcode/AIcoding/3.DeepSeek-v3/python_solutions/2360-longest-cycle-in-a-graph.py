class Solution:
    def longestCycle(self, edges: List[int]) -> int:
        n = len(edges)
        visited = [False] * n
        max_cycle = -1

        for i in range(n):
            if not visited[i]:
                current = i
                path = {}
                distance = 0
                while current != -1:
                    if current in path:
                        max_cycle = max(max_cycle, distance - path[current])
                        break
                    if visited[current]:
                        break
                    visited[current] = True
                    path[current] = distance
                    distance += 1
                    current = edges[current]
        return max_cycle