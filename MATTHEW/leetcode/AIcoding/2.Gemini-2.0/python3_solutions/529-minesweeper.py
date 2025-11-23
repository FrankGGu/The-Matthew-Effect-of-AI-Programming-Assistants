class Solution:
    def updateBoard(self, board: List[List[str]], click: List[int]) -> List[List[str]]:
        def get_neighbors(row, col):
            neighbors = []
            for i in range(max(0, row - 1), min(len(board), row + 2)):
                for j in range(max(0, col - 1), min(len(board[0]), col + 2)):
                    if i != row or j != col:
                        neighbors.append((i, j))
            return neighbors

        row, col = click
        if board[row][col] == 'M':
            board[row][col] = 'X'
            return board

        queue = [(row, col)]
        visited = set()

        while queue:
            curr_row, curr_col = queue.pop(0)

            if (curr_row, curr_col) in visited:
                continue
            visited.add((curr_row, curr_col))

            mine_count = 0
            neighbors = get_neighbors(curr_row, curr_col)
            for neighbor_row, neighbor_col in neighbors:
                if board[neighbor_row][neighbor_col] == 'M':
                    mine_count += 1

            if mine_count > 0:
                board[curr_row][curr_col] = str(mine_count)
            else:
                board[curr_row][curr_col] = 'B'
                for neighbor_row, neighbor_col in neighbors:
                    if board[neighbor_row][neighbor_col] == 'E':
                        queue.append((neighbor_row, neighbor_col))

        return board