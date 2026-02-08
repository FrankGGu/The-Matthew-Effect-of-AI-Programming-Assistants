class Solution:
    def hasValidPath(self, grid: List[List[str]]) -> bool:
        rows, cols = len(grid), len(grid[0])
        directions = [(1, 0), (0, 1), (-1, 0), (0, -1)]
        valid_paths = {'(': [0, 1], ')': [1, 0], '{': [0, 1], '}': [1, 0], '[': [0, 1], ']': [1, 0]}
        stack = [(0, 0, 0)]  # row, col, balance

        while stack:
            r, c, balance = stack.pop()
            if r == rows - 1 and c == cols - 1:
                if balance == 0:
                    return True
                continue

            for dr, dc in directions:
                nr, nc = r + dr, c + dc
                if 0 <= nr < rows and 0 <= nc < cols:
                    if grid[nr][nc] in valid_paths:
                        new_balance = balance + (1 if grid[nr][nc] in '({[' else -1)
                        if new_balance >= 0:
                            stack.append((nr, nc, new_balance))

        return False