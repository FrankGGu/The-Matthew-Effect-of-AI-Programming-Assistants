class Solution {
    public int numRookCaptures(char[][] board) {
        int rookX = -1, rookY = -1;
        for (int i = 0; i < 8; i++) {
            for (int j = 0; j < 8; j++) {
                if (board[i][j] == 'R') {
                    rookX = i;
                    rookY = j;
                    break;
                }
            }
            if (rookX != -1) break;
        }

        int[][] directions = {{-1, 0}, {1, 0}, {0, -1}, {0, 1}};
        int count = 0;

        for (int[] dir : directions) {
            int x = rookX + dir[0];
            int y = rookY + dir[1];
            while (x >= 0 && x < 8 && y >= 0 && y < 8) {
                if (board[x][y] == 'p') {
                    count++;
                    break;
                } else if (board[x][y] == 'B') {
                    break;
                }
                x += dir[0];
                y += dir[1];
            }
        }

        return count;
    }
}