import java.util.Arrays;

public class Solution {
    public int maxSumTwoNoOverlap(int[] nums, int firstLen, int secondLen) {
        return Math.max(maxSum(nums, firstLen, secondLen), maxSum(nums, secondLen, firstLen));
    }

    private int maxSum(int[] nums, int firstLen, int secondLen) {
        int n = nums.length;
        int[] prefixSum = new int[n + 1];
        for (int i = 0; i < n; i++) {
            prefixSum[i + 1] = prefixSum[i] + nums[i];
        }

        int maxFirstSum = 0, maxTotal = 0;
        for (int i = firstLen + secondLen - 1; i < n; i++) {
            maxFirstSum = Math.max(maxFirstSum, prefixSum[i - secondLen + 1] - prefixSum[i - firstLen - secondLen + 1]);
            maxTotal = Math.max(maxTotal, maxFirstSum + prefixSum[i + 1] - prefixSum[i - secondLen + 1]);
        }

        return maxTotal;
    }
}