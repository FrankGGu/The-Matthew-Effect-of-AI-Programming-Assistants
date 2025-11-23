import collections

class Solution:
    def minimumMoves(self, grid: list[list[int]]) -> int:
        n = len(grid)

        # State: (r, c, orientation)
        # (r, c) is the top-left cell of the snake.
        # orientation: 0 for horizontal (occupies (r,c) and (r,c+1))
        #              1 for vertical (occupies (r,c) and (r+1,c))

        # Initial state: snake at (0,0) and (0,1), horizontal, 0 moves
        queue = collections.deque([(0, 0, 0, 0)]) 
        visited = set([(0, 0, 0)])

        # Target state: snake at (n-1, n-2) and (n-1, n-1), horizontal
        target_r, target_c, target_orientation = n - 1, n - 2, 0

        while queue:
            r, c, orientation, moves = queue.popleft()

            if r == target_r and c == target_c and orientation == target_orientation:
                return moves

            # Possible moves
            if orientation == 0:  # Horizontal: (r, c) and (r, c+1)
                # 1. Move right
                # New position: (r, c+1) and (r, c+2)
                if c + 2 < n and grid[r][c+2] == 0:
                    next_state = (r, c + 1, 0)
                    if next_state not in visited:
                        visited.add(next_state)
                        queue.append((r, c + 1, 0, moves + 1))

                # 2. Move down
                # New position: (r+1, c) and (r+1, c+1)
                if r + 1 < n and grid[r+1][c] == 0 and grid[r+1][c+1] == 0:
                    next_state = (r + 1, c, 0)
                    if next_state not in visited:
                        visited.add(next_state)
                        queue.append((r + 1, c, 0, moves + 1))

                # 3. Rotate clockwise
                # New position: (r, c) and (r+1, c) (vertical)
                # Requires (r+1, c) and (r+1, c+1) to be empty
                if r + 1 < n and c + 1 < n and grid[r+1][c] == 0 and grid[r+1][c+1] == 0:
                    next_state = (r, c, 1)
                    if next_state not in visited:
                        visited.add(next_state)
                        queue.append((r, c, 1, moves + 1))

            else:  # Vertical: (r, c) and (r+1, c)
                # 1. Move right
                # New position: (r, c+1) and (r+1, c+1)
                if c + 1 < n and grid[r][c+1] == 0 and grid[r+1][c+1] == 0:
                    next_state = (r, c + 1, 1)
                    if next_state not in visited:
                        visited.add(next_state)
                        queue.append((r, c + 1, 1, moves + 1))

                # 2. Move down
                # New position: (r+1, c) and (r+2, c)
                if r + 2 < n and grid[r+2][c] == 0:
                    next_state = (r + 1, c, 1)
                    if next_state not in visited:
                        visited.add(next_state)
                        queue.append((r + 1, c, 1, moves + 1))

                # 3. Rotate counter-clockwise
                # New position: (r, c) and (r, c+1) (horizontal)
                # Requires (r, c+1) and (r+1, c+1) to be empty
                if r + 1 < n and c + 1 < n and grid[r][c+1] == 0 and grid[r+1][c+1] == 0:
                    next_state = (r, c, 0)
                    if next_state not in visited:
                        visited.add(next_state)
                        queue.append((r, c, 0, moves + 1))

        return -1 # Target not reachable