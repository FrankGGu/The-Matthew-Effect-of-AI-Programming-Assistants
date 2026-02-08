class Solution {
    public int minimizeTheDifference(int[][] mat, int target) {
        int m = mat.length, n = mat[0].length;
        Set<Integer> dp = new HashSet<>();
        dp.add(0);

        for (int i = 0; i < m; i++) {
            Set<Integer> newDp = new HashSet<>();
            int minNext = Integer.MAX_VALUE;
            for (int num : dp) {
                for (int j = 0; j < n; j++) {
                    int sum = num + mat[i][j];
                    if (sum <= 2 * target) {
                        newDp.add(sum);
                    } else {
                        if (sum < minNext) {
                            minNext = sum;
                        }
                    }
                }
            }
            if (minNext != Integer.MAX_VALUE) {
                newDp.add(minNext);
            }
            dp = newDp;
        }

        int minDiff = Integer.MAX_VALUE;
        for (int num : dp) {
            int diff = Math.abs(num - target);
            if (diff < minDiff) {
                minDiff = diff;
            }
        }
        return minDiff;
    }
}