class Solution {
    public double[] twoSum(int n) {
        int[] dp = new int[6];
        Arrays.fill(dp, 1);

        for (int i = 2; i <= n; i++) {
            int[] temp = new int[5 * i + 1];
            for (int j = 0; j < dp.length; j++) {
                for (int k = 1; k <= 6; k++) {
                    temp[j + k] += dp[j];
                }
            }
            dp = temp;
        }

        double total = Math.pow(6, n);
        double[] result = new double[dp.length];
        for (int i = 0; i < dp.length; i++) {
            result[i] = dp[i] / total;
        }

        return result;
    }
}