class Solution {
    public double largestSumOfAverages(int[] nums, int k) {
        int n = nums.length;
        double[] prefixSum = new double[n + 1];
        for (int i = 0; i i <= i; j++) {
                    double avg = (prefixSum[i + 1] - prefixSum[j]) / (i - j + 1);
                    dp[i][kk] = Math.max(dp[i][kk], dp[j - 1][kk - 1] + avg);
                }
            }
        }
        return dp[n - 1][k];
    }
}