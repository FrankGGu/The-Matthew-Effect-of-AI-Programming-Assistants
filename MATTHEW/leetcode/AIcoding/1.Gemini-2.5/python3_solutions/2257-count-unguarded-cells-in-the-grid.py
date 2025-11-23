class Solution:
    def countUnguarded(self, m: int, n: int, guards: List[List[int]], walls: List[List[int]]) -> int:
        grid = [[0] * n for _ in range(m)] # 0: empty, 1: guard, 2: wall, 3: guarded

        for r, c in guards:
            grid[r][c] = 1
        for r, c in walls:
            grid[r][c] = 2

        # Pass 1: Left to Right
        for r in range(m):
            has_guard_left = False
            for c in range(n):
                if grid[r][c] == 1: # Guard
                    has_guard_left = True
                elif grid[r][c] == 2: # Wall
                    has_guard_left = False
                elif grid[r][c] == 0 and has_guard_left: # Empty and covered
                    grid[r][c] = 3

        # Pass 2: Right to Left
        for r in range(m):
            has_guard_right = False
            for c in range(n - 1, -1, -1):
                if grid[r][c] == 1: # Guard
                    has_guard_right = True
                elif grid[r][c] == 2: # Wall
                    has_guard_right = False
                elif grid[r][c] == 0 and has_guard_right: # Empty and covered
                    grid[r][c] = 3

        # Pass 3: Top to Bottom
        for c in range(n):
            has_guard_up = False
            for r in range(m):
                if grid[r][c] == 1: # Guard
                    has_guard_up = True
                elif grid[r][c] == 2: # Wall
                    has_guard_up = False
                elif grid[r][c] == 0 and has_guard_up: # Empty and covered
                    grid[r][c] = 3

        # Pass 4: Bottom to Top
        for c in range(n):
            has_guard_down = False
            for r in range(m - 1, -1, -1):
                if grid[r][c] == 1: # Guard
                    has_guard_down = True
                elif grid[r][c] == 2: # Wall
                    has_guard_down = False
                elif grid[r][c] == 0 and has_guard_down: # Empty and covered
                    grid[r][c] = 3

        unguarded_count = 0
        for r in range(m):
            for c in range(n):
                if grid[r][c] == 0:
                    unguarded_count += 1

        return unguarded_count