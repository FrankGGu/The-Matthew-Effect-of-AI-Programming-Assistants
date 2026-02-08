def countBattleships(board):
    if not board:
        return 0

    count = 0
    rows, cols = len(board), len(board[0])

    for i in range(rows):
        for j in range(cols):
            if board[i][j] == 'X':
                if i == 0 or board[i-1][j] == '.':
                    if j == 0 or board[i][j-1] == '.':
                        count += 1
    return count