import java.util.Stack;

public class Solution {
    public int maxSumMinProduct(int[] nums) {
        int n = nums.length;
        long mod = 1000000007;
        long[] prefixSum = new long[n + 1];
        for (int i = 0; i < n; i++) {
            prefixSum[i + 1] = (prefixSum[i] + nums[i]) % mod;
        }

        Stack<Integer> stack = new Stack<>();
        long maxProduct = 0;

        for (int i = 0; i <= n; i++) {
            while (!stack.isEmpty() && (i == n || nums[stack.peek()] > nums[i])) {
                int j = stack.pop();
                long minValue = nums[j];
                long sum = (prefixSum[i] - prefixSum[stack.isEmpty() ? 0 : stack.peek() + 1] + mod) % mod;
                maxProduct = Math.max(maxProduct, minValue * sum);
            }
            stack.push(i);
        }

        return (int) (maxProduct % mod);
    }
}