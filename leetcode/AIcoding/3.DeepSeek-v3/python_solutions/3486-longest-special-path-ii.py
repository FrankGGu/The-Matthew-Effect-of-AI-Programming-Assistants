class Solution:
    def longestCycle(self, edges: List[int]) -> int:
        n = len(edges)
        visited = [False] * n
        max_cycle = -1

        for i in range(n):
            if not visited[i]:
                cycle = {}
                current = i
                pos = 0
                while True:
                    if current == -1:
                        break
                    if visited[current]:
                        if current in cycle:
                            max_cycle = max(max_cycle, pos - cycle[current])
                        break
                    visited[current] = True
                    cycle[current] = pos
                    pos += 1
                    current = edges[current]

        return max_cycle