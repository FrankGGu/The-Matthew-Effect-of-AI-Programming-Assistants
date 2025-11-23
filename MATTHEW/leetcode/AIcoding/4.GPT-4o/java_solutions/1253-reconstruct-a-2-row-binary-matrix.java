class Solution {
    public int[][] reconstructMatrix(int upper, int lower, int[] colsum) {
        int n = colsum.length;
        int[][] result = new int[2][n];

        for (int i = 0; i < n; i++) {
            if (colsum[i] == 2) {
                if (upper > 0 && lower > 0) {
                    result[0][i] = 1;
                    result[1][i] = 1;
                    upper--;
                    lower--;
                } else {
                    return new int[0][0];
                }
            } else if (colsum[i] == 1) {
                if (upper > lower) {
                    result[0][i] = 1;
                    upper--;
                } else {
                    result[1][i] = 1;
                    lower--;
                }
            }
        }

        return (upper == 0 && lower == 0) ? result : new int[0][0];
    }
}