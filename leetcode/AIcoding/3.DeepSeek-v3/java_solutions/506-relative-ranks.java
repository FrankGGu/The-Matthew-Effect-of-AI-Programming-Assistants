class Solution {
    public String[] findRelativeRanks(int[] score) {
        int n = score.length;
        int[][] sorted = new int[n][2];
        for (int i = 0; i < n; i++) {
            sorted[i][0] = score[i];
            sorted[i][1] = i;
        }

        Arrays.sort(sorted, (a, b) -> b[0] - a[0]);

        String[] res = new String[n];
        for (int i = 0; i < n; i++) {
            if (i == 0) {
                res[sorted[i][1]] = "Gold Medal";
            } else if (i == 1) {
                res[sorted[i][1]] = "Silver Medal";
            } else if (i == 2) {
                res[sorted[i][1]] = "Bronze Medal";
            } else {
                res[sorted[i][1]] = String.valueOf(i + 1);
            }
        }

        return res;
    }
}