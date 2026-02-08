class Solution:
    def hitBricks(self, grid: List[List[int]], hits: List[List[int]]) -> List[int]:
        m, n = len(grid), len(grid[0])
        def is_valid(r, c):
            return 0 <= r < m and 0 <= c < n

        def dfs(r, c):
            if not is_valid(r, c) or grid[r][c] != 1:
                return 0
            grid[r][c] = 2
            count = 1
            for dr, dc in [(0, 1), (0, -1), (1, 0), (-1, 0)]:
                count += dfs(r + dr, c + dc)
            return count

        for r, c in hits:
            if grid[r][c] == 1:
                grid[r][c] = -1

        dfs_result = dfs(0, 0)

        result = []
        for i in range(len(hits) - 1, -1, -1):
            r, c = hits[i]
            if grid[r][c] == -1:
                grid[r][c] = 1

                original_dfs_result = dfs_result

                is_connected = False
                for dr, dc in [(0, 1), (0, -1), (1, 0), (-1, 0)]:
                    nr, nc = r + dr, c + dc
                    if is_valid(nr, nc) and grid[nr][nc] == 2:
                        is_connected = True
                        break
                if r == 0:
                    is_connected = True

                if is_connected:
                    new_bricks = dfs(r, c)
                    dfs_result += new_bricks
                    result.append(new_bricks -1)
                else:
                    result.append(0)
            else:
                result.append(0)

        return result[::-1]