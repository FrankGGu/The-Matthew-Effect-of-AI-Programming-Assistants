class Solution:
    def placeWordInCrossword(self, board: List[List[str]], word: str) -> bool:
        def can_place(word, row, col, direction):
            for i in range(len(word)):
                if direction == 0:  # horizontal
                    if col + i >= len(board[0]) or (board[row][col + i] != ' ' and board[row][col + i] != word[i]):
                        return False
                else:  # vertical
                    if row + i >= len(board) or (board[row + i][col] != ' ' and board[row + i][col] != word[i]):
                        return False
            return True

        def place(word, row, col, direction):
            for i in range(len(word)):
                if direction == 0:
                    board[row][col + i] = word[i]
                else:
                    board[row + i][col] = word[i]

        def remove(word, row, col, direction):
            for i in range(len(word)):
                if direction == 0:
                    board[row][col + i] = ' '
                else:
                    board[row + i][col] = ' '

        for r in range(len(board)):
            for c in range(len(board[0])):
                if board[r][c] == ' ' or board[r][c] == word[0]:
                    if can_place(word, r, c, 0):
                        place(word, r, c, 0)
                        if all(board[r][c] == ' ' or board[r][c] == word[i] for i in range(len(board[0]))):
                            return True
                        remove(word, r, c, 0)
                    if can_place(word, r, c, 1):
                        place(word, r, c, 1)
                        if all(board[r][c] == ' ' or board[r][c] == word[i] for i in range(len(board))):
                            return True
                        remove(word, r, c, 1)
        return False