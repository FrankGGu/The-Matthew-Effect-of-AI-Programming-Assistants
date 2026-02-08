import collections

class Solution:
    def maximumDetonatedBombs(self, bombs: list[list[int]]) -> int:
        n = len(bombs)
        if n == 0:
            return 0

        adj = [[] for _ in range(n)]

        for i in range(n):
            xi, yi, ri = bombs[i]
            for j in range(n):
                if i == j:
                    continue
                xj, yj, rj = bombs[j]

                dist_sq = (xj - xi)**2 + (yj - yi)**2

                if dist_sq <= ri**2:
                    adj[i].append(j)

        max_detonated = 0

        for i in range(n):
            q = collections.deque([i])
            visited = {i}
            current_detonated_count = 0

            while q:
                u = q.popleft()
                current_detonated_count += 1

                for v in adj[u]:
                    if v not in visited:
                        visited.add(v)
                        q.append(v)

            max_detonated = max(max_detonated, current_detonated_count)

        return max_detonated