class Solution {
    public String findTheString(int[][] lcp) {
        int n = lcp.length;
        StringBuilder sb = new StringBuilder();
        boolean[] used = new boolean[n];

        for (int i = 0; i < n; i++) {
            if (!used[i]) {
                sb.append('a');
                used[i] = true;
                for (int j = 0; j < n; j++) {
                    if (lcp[i][j] == 1) {
                        used[j] = true;
                    }
                }
            } else {
                sb.append('b');
            }
        }

        return sb.toString();
    }
}