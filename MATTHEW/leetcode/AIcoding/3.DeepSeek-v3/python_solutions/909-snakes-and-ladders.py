class Solution:
    def snakesAndLadders(self, board: List[List[int]]) -> int:
        n = len(board)
        def get_pos(num):
            num -= 1
            row = num // n
            col = num % n
            if row % 2 == 1:
                col = n - 1 - col
            row = n - 1 - row
            return (row, col)

        visited = set()
        queue = deque()
        queue.append((1, 0))
        visited.add(1)

        while queue:
            num, moves = queue.popleft()
            if num == n * n:
                return moves
            for i in range(1, 7):
                next_num = num + i
                if next_num > n * n:
                    continue
                r, c = get_pos(next_num)
                if board[r][c] != -1:
                    next_num = board[r][c]
                if next_num not in visited:
                    visited.add(next_num)
                    queue.append((next_num, moves + 1))
        return -1