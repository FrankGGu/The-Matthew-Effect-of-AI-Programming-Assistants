class Solution {
    private long[][] C = new long[31][31];

    public Solution() {
        C[0][0] = 1;
        for (int i = 1; i <= 30; i++) {
            C[i][0] = 1;
            for (int j = 1; j <= i; j++) {
                C[i][j] = C[i-1][j-1] + C[i-1][j];
            }
        }
    }

    public String kthSmallestPath(int[] target, int k) {
        int row = target[0];
        int col = target[1];

        StringBuilder sb = new StringBuilder();
        int remainingH = col;
        int remainingV = row;

        for (int i = 0; i < row + col; i++) {
            if (remainingH > 0) {
                long waysIfH = C[remainingH - 1 + remainingV][remainingV];

                if (k <= waysIfH) {
                    sb.append('H');
                    remainingH--;
                } else {
                    sb.append('V');
                    remainingV--;
                    k -= waysIfH;
                }
            } else {
                sb.append('V');
                remainingV--;
            }
        }

        return sb.toString();
    }
}