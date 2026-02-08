from collections import deque

class Solution:
    def snakesAndLadders(self, board: list[list[int]]) -> int:
        n = len(board)
        board.reverse()

        def get_coordinates(square):
            row = (square - 1) // n
            col = (square - 1) % n
            if row % 2 == 1:
                col = n - 1 - col
            return row, col

        q = deque([(1, 0)])
        visited = {1}

        while q:
            square, moves = q.popleft()
            if square == n * n:
                return moves

            for i in range(1, 7):
                next_square = square + i
                if next_square > n * n:
                    break

                row, col = get_coordinates(next_square)
                if board[row][col] != -1:
                    next_square = board[row][col]

                if next_square not in visited:
                    visited.add(next_square)
                    q.append((next_square, moves + 1))

        return -1