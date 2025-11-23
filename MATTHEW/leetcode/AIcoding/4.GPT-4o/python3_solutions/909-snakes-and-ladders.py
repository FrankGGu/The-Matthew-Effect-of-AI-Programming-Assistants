class Solution:
    def snakesAndLadders(self, board: List[List[int]]) -> int:
        n = len(board)
        visited = set()
        queue = collections.deque([(1, 0)])  # (current square, number of moves)

        while queue:
            current, moves = queue.popleft()
            if current == n * n:
                return moves

            for dice in range(1, 7):
                next_square = current + dice
                if next_square <= n * n:
                    row, col = divmod(next_square - 1, n)
                    if board[n - 1 - row][col] != -1:
                        next_square = board[n - 1 - row][col]
                    if next_square not in visited:
                        visited.add(next_square)
                        queue.append((next_square, moves + 1))

        return -1