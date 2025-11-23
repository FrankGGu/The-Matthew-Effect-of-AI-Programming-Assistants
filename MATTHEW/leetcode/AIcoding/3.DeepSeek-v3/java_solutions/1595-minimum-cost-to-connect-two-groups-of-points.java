class Solution {
    public int connectTwoGroups(List<List<Integer>> cost) {
        int size1 = cost.size();
        int size2 = cost.get(0).size();
        int[] minCost2 = new int[size2];
        Arrays.fill(minCost2, Integer.MAX_VALUE);
        for (int j = 0; j < size2; j++) {
            for (int i = 0; i < size1; i++) {
                minCost2[j] = Math.min(minCost2[j], cost.get(i).get(j));
            }
        }
        int[][] dp = new int[size1 + 1][1 << size2];
        for (int i = 0; i <= size1; i++) {
            Arrays.fill(dp[i], Integer.MAX_VALUE / 2);
        }
        dp[0][0] = 0;
        for (int i = 1; i <= size1; i++) {
            for (int mask = 0; mask < (1 << size2); mask++) {
                for (int j = 0; j < size2; j++) {
                    int newMask = mask | (1 << j);
                    dp[i][newMask] = Math.min(dp[i][newMask], dp[i - 1][mask] + cost.get(i - 1).get(j));
                }
                if (i == size1) {
                    for (int subMask = mask; subMask > 0; subMask = (subMask - 1) & mask) {
                        int sum = 0;
                        for (int j = 0; j < size2; j++) {
                            if ((subMask & (1 << j)) != 0) {
                                sum += minCost2[j];
                            }
                        }
                        dp[i][mask] = Math.min(dp[i][mask], dp[i][subMask] + sum);
                    }
                }
            }
        }
        return dp[size1][(1 << size2) - 1];
    }
}