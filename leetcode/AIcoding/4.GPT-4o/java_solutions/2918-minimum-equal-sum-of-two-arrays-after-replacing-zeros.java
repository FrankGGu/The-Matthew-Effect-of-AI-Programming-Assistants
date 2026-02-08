import java.util.Arrays;

public class Solution {
    public int minEqualSum(int[] arr1, int[] arr2) {
        int sum1 = Arrays.stream(arr1).sum();
        int sum2 = Arrays.stream(arr2).sum();
        int maxSum = Math.max(sum1, sum2);

        int[] dp = new int[maxSum + 1];
        dp[0] = 1;

        for (int num : arr1) {
            if (num == 0) continue;
            for (int j = maxSum; j >= num; j--) {
                dp[j] |= dp[j - num];
            }
        }

        for (int num : arr2) {
            if (num == 0) continue;
            for (int j = maxSum; j >= num; j--) {
                dp[j] |= dp[j - num];
            }
        }

        for (int target = maxSum; target >= 0; target--) {
            if (dp[target]) {
                return maxSum - target;
            }
        }

        return maxSum;
    }
}