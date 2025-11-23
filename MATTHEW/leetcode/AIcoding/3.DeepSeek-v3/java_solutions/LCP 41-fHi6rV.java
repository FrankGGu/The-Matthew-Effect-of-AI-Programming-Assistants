class Solution {
    private static final int[][] DIRECTIONS = {{-1, -1}, {-1, 0}, {-1, 1}, {0, -1}, {0, 1}, {1, -1}, {1, 0}, {1, 1}};

    public int flipChess(String[] chessboard) {
        int maxFlips = 0;
        int rows = chessboard.length;
        int cols = chessboard[0].length();
        char[][] board = new char[rows][cols];
        for (int i = 0; i < rows; i++) {
            board[i] = chessboard[i].toCharArray();
        }

        for (int i = 0; i < rows; i++) {
            for (int j = 0; j < cols; j++) {
                if (board[i][j] == '.') {
                    char[][] tempBoard = new char[rows][cols];
                    for (int k = 0; k < rows; k++) {
                        tempBoard[k] = chessboard[k].toCharArray();
                    }
                    tempBoard[i][j] = 'X';
                    int flips = simulate(tempBoard, i, j);
                    if (flips > maxFlips) {
                        maxFlips = flips;
                    }
                }
            }
        }
        return maxFlips;
    }

    private int simulate(char[][] board, int x, int y) {
        int flips = 0;
        Queue<int[]> queue = new LinkedList<>();
        queue.offer(new int[]{x, y});

        while (!queue.isEmpty()) {
            int[] pos = queue.poll();
            int i = pos[0], j = pos[1];
            for (int[] dir : DIRECTIONS) {
                int ni = i + dir[0], nj = j + dir[1];
                if (isValid(board, ni, nj) && board[ni][nj] == 'O') {
                    List<int[]> path = new ArrayList<>();
                    path.add(new int[]{ni, nj});
                    ni += dir[0];
                    nj += dir[1];
                    while (isValid(board, ni, nj) {
                        if (board[ni][nj] == 'X') {
                            for (int[] p : path) {
                                board[p[0]][p[1]] = 'X';
                                queue.offer(new int[]{p[0], p[1]});
                                flips++;
                            }
                            break;
                        } else if (board[ni][nj] == '.') {
                            break;
                        }
                        path.add(new int[]{ni, nj});
                        ni += dir[0];
                        nj += dir[1];
                    }
                }
            }
        }
        return flips;
    }

    private boolean isValid(char[][] board, int x, int y) {
        return x >= 0 && x < board.length && y >= 0 && y < board[0].length;
    }
}