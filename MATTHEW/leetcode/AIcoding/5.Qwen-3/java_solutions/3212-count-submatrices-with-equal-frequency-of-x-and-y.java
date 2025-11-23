public class Solution {
    public int countSubmatrices(int[][] grid) {
        int rows = grid.length;
        int cols = grid[0].length;
        int count = 0;

        for (int i = 0; i < rows; i++) {
            int[] freq = new int[2];
            for (int j = i; j < rows; j++) {
                freq[0] = 0;
                freq[1] = 0;
                for (int k = 0; k < cols; k++) {
                    if (grid[j][k] == 'X') {
                        freq[0]++;
                    } else if (grid[j][k] == 'Y') {
                        freq[1]++;
                    }
                    if (freq[0] == freq[1]) {
                        count++;
                    }
                }
            }
        }

        return count;
    }
}