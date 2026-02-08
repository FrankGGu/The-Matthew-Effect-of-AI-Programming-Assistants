class Solution:
    def gameOfLife(self, board: list[list[int]]) -> None:
        """
        Do not return anything, modify board in-place instead.
        """
        m = len(board)
        n = len(board[0])

        # Define all 8 possible directions for neighbors
        directions = [
            (-1, -1), (-1, 0), (-1, 1),
            (0, -1),           (0, 1),
            (1, -1),  (1, 0),  (1, 1)
        ]

        # First pass: Update the board with intermediate states
        # 0: dead -> dead
        # 1: live -> live
        # 2: live -> dead (originally 1, becomes 0)
        # 3: dead -> live (originally 0, becomes 1)
        for r in range(m):
            for c in range(n):
                live_neighbors = 0
                for dr, dc in directions:
                    nr, nc = r + dr, c + dc

                    # Check if the neighbor is within bounds
                    if 0 <= nr < m and 0 <= nc < n:
                        # A neighbor is considered 'live' if its original state was 1.
                        # This means it could be current state 1 (live -> live)
                        # or current state 2 (live -> dead, but was live for this generation's calculation).
                        if board[nr][nc] == 1 or board[nr][nc] == 2:
                            live_neighbors += 1

                # Apply Game of Life rules
                if board[r][c] == 1:  # Current cell is live
                    if live_neighbors < 2 or live_neighbors > 3:
                        board[r][c] = 2  # Mark as live -> dead
                    # Else: live_neighbors is 2 or 3, cell remains live (board[r][c] stays 1)
                else:  # Current cell is dead (board[r][c] == 0)
                    if live_neighbors == 3:
                        board[r][c] = 3  # Mark as dead -> live

        # Second pass: Convert intermediate states to final states
        for r in range(m):
            for c in range(n):
                if board[r][c] == 2:
                    board[r][c] = 0  # Was live, becomes dead
                elif board[r][c] == 3:
                    board[r][c] = 1  # Was dead, becomes live