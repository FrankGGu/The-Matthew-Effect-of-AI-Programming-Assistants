import java.util.Deque;
import java.util.LinkedList;

public class Solution {
    public long[] maxAndMinSums(int[] nums, int k) {
        long[] result = new long[2];
        long maxSum = getMaxSum(nums, k);
        long minSum = getMinSum(nums, k);
        result[0] = maxSum;
        result[1] = minSum;
        return result;
    }

    private long getMaxSum(int[] nums, int k) {
        Deque<Integer> deque = new LinkedList<>();
        long maxSum = 0, sum = 0;

        for (int i = 0; i < nums.length; i++) {
            sum += nums[i];
            if (i >= k) {
                sum -= nums[i - k];
            }
            if (i >= k - 1) {
                maxSum = Math.max(maxSum, sum);
            }
        }
        return maxSum;
    }

    private long getMinSum(int[] nums, int k) {
        Deque<Integer> deque = new LinkedList<>();
        long minSum = Long.MAX_VALUE, sum = 0;

        for (int i = 0; i < nums.length; i++) {
            sum += nums[i];
            if (i >= k) {
                sum -= nums[i - k];
            }
            if (i >= k - 1) {
                minSum = Math.min(minSum, sum);
            }
        }
        return minSum;
    }
}