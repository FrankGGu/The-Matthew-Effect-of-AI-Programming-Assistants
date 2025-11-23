class Solution {
    public String kthSmallestPath(int[] destination, int k) {
        int v = destination[0];
        int h = destination[1];
        int total = v + h;
        int[][] comb = new int[total + 1][v + 1];
        comb[0][0] = 1;
        for (int i = 1; i <= total; i++) {
            comb[i][0] = 1;
            for (int j = 1; j <= v; j++) {
                comb[i][j] = comb[i - 1][j - 1] + comb[i - 1][j];
            }
        }
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < total; i++) {
            if (h > 0) {
                int c = comb[h + v - 1][v];
                if (k > c) {
                    sb.append('V');
                    v--;
                    k -= c;
                } else {
                    sb.append('H');
                    h--;
                }
            } else {
                sb.append('V');
                v--;
            }
        }
        return sb.toString();
    }
}