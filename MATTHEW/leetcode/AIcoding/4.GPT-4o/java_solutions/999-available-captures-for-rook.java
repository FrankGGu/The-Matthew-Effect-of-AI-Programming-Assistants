class Solution {
    public int numRookCaptures(char[][] board) {
        int captures = 0;
        int[] rookPosition = new int[2];

        for (int i = 0; i < 8; i++) {
            for (int j = 0; j < 8; j++) {
                if (board[i][j] == 'R') {
                    rookPosition[0] = i;
                    rookPosition[1] = j;
                    break;
                }
            }
        }

        captures += countCaptures(rookPosition[0], rookPosition[1], 0, 1, board); // right
        captures += countCaptures(rookPosition[0], rookPosition[1], 0, -1, board); // left
        captures += countCaptures(rookPosition[0], rookPosition[1], 1, 0, board); // down
        captures += countCaptures(rookPosition[0], rookPosition[1], -1, 0, board); // up

        return captures;
    }

    private int countCaptures(int x, int y, int dx, int dy, char[][] board) {
        int count = 0;
        while (x + dx >= 0 && x + dx < 8 && y + dy >= 0 && y + dy < 8) {
            x += dx;
            y += dy;
            if (board[x][y] == 'B') {
                break;
            }
            if (board[x][y] == 'p') {
                count++;
                break;
            }
        }
        return count;
    }
}