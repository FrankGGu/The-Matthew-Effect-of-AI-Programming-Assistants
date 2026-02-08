from collections import deque

def maximumMinutes(forest: list[list[int]]) -> int:
    m, n = len(forest), len(forest[0])

    def bfs(start_time):
        visited = [[False] * n for _ in range(m)]
        q = deque([(0, 0, start_time)])
        visited[0][0] = True

        fire_visited = [[False] * n for _ in range(m)]
        fire_q = deque()

        for r in range(m):
            for c in range(n):
                if forest[r][c] == 1:
                    fire_q.append((r, c, 0))
                    fire_visited[r][c] = True

        directions = [(0, 1), (0, -1), (1, 0), (-1, 0)]

        while q:
            r, c, time = q.popleft()

            if r == m - 1 and c == n - 1:
                return True

            # Spread fire
            fire_spread = []
            fire_q_len = len(fire_q)
            for _ in range(fire_q_len):
                fr, fc, ft = fire_q.popleft()
                for dr, dc in directions:
                    nfr, nfc = fr + dr, fc + dc
                    if 0 <= nfr < m and 0 <= nfc < n and forest[nfr][nfc] == 0 and not fire_visited[nfr][nfc]:
                        fire_visited[nfr][nfc] = True
                        fire_spread.append((nfr, nfc))
                        fire_q.append((nfr, nfc, ft + 1))

            # Move person
            for dr, dc in directions:
                nr, nc = r + dr, c + dc
                if 0 <= nr < m and 0 <= nc < n and forest[nr][nc] == 0 and not visited[nr][nc]:
                    # Check if fire reaches before person
                    fire_time = float('inf')
                    for fr, fc, ft in fire_spread:
                        if nr == fr and nc == fc:
                            fire_time = time + 1
                            break

                    if fire_time > time + 1:
                        visited[nr][nc] = True
                        q.append((nr, nc, time + 1))

        return False

    if not bfs(0):
        return -1

    low, high = 0, 10**9
    ans = -1

    while low <= high:
        mid = (low + high) // 2
        if bfs(mid):
            ans = mid
            low = mid + 1
        else:
            high = mid - 1

    return ans if ans < 10**9 else 10**9