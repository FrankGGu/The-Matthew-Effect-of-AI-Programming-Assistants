class Solution {
    public int[] findBall(int[][] grid) {
        int m = grid.length;
        int n = grid[0].length;
        int[] answer = new int[n];

        for (int j = 0; j < n; j++) {
            int currentCol = j;
            for (int i = 0; i < m; i++) {
                int boardType = grid[i][currentCol];

                if (boardType == 1) { // Board slopes right
                    if (currentCol + 1 >= n || grid[i][currentCol + 1] == -1) {
                        currentCol = -1;
                        break;
                    } else {
                        currentCol++;
                    }
                } else { // Board slopes left
                    if (currentCol - 1 < 0 || grid[i][currentCol - 1] == 1) {
                        currentCol = -1;
                        break;
                    } else {
                        currentCol--;
                    }
                }
            }
            answer[j] = currentCol;
        }

        return answer;
    }
}