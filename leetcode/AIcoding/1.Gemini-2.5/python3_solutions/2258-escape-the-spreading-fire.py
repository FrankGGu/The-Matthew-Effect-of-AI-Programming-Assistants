import collections

class Solution:
    def maximumMinutes(self, grid: list[list[int]]) -> int:
        R, C = len(grid), len(grid[0])

        fire_time = [[float('inf')] * C for _ in range(R)]
        q_fire = collections.deque()

        for r in range(R):
            for c in range(C):
                if grid[r][c] == 1:
                    q_fire.append((r, c, 0))
                    fire_time[r][c] = 0

        while q_fire:
            r, c, t = q_fire.popleft()

            for dr, dc in [(0, 1), (0, -1), (1, 0), (-1, 0)]:
                nr, nc = r + dr, c + dc
                if 0 <= nr < R and 0 <= nc < C and grid[nr][nc] != 2 and fire_time[nr][nc] == float('inf'):
                    fire_time[nr][nc] = t + 1
                    q_fire.append((nr, nc, t + 1))

        low = 0
        high = R * C * 2
        ans = -1

        def check(wait_time):
            if fire_time[0][0] <= wait_time:
                return False

            man_time = [[float('inf')] * C for _ in range(R)]
            q_man = collections.deque()

            q_man.append((0, 0, wait_time))
            man_time[0][0] = wait_time

            while q_man:
                r, c, t = q_man.popleft()

                if r == R - 1 and c == C - 1:
                    return True

                for dr, dc in [(0, 1), (0, -1), (1, 0), (-1, 0)]:
                    nr, nc = r + dr, c + dc
                    next_t = t + 1

                    if 0 <= nr < R and 0 <= nc < C and grid[nr][nc] != 2 and man_time[nr][nc] == float('inf'):
                        if nr == R - 1 and nc == C - 1:
                            if next_t <= fire_time[nr][nc]:
                                man_time[nr][nc] = next_t
                                q_man.append((nr, nc, next_t))
                        else:
                            if next_t < fire_time[nr][nc]:
                                man_time[nr][nc] = next_t
                                q_man.append((nr, nc, next_t))
            return False

        while low <= high:
            mid = low + (high - low) // 2
            if check(mid):
                ans = mid
                low = mid + 1
            else:
                high = mid - 1

        return ans