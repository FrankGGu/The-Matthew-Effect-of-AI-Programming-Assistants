import java.util.Stack;

class Solution {
    public long maxSumMinProduct(int[] nums) {
        int n = nums.length;

        long[] prefixSums = new long[n + 1];
        for (int i = 0; i < n; i++) {
            prefixSums[i + 1] = prefixSums[i] + nums[i];
        }

        int[] left = new int[n];
        Stack<Integer> stack = new Stack<>();
        for (int i = 0; i < n; i++) {
            while (!stack.isEmpty() && nums[stack.peek()] >= nums[i]) {
                stack.pop();
            }
            left[i] = stack.isEmpty() ? -1 : stack.peek();
            stack.push(i);
        }

        int[] right = new int[n];
        stack.clear();
        for (int i = n - 1; i >= 0; i--) {
            while (!stack.isEmpty() && nums[stack.peek()] >= nums[i]) {
                stack.pop();
            }
            right[i] = stack.isEmpty() ? n : stack.peek();
            stack.push(i);
        }

        long maxProduct = 0;
        for (int i = 0; i < n; i++) {
            int L_idx = left[i] + 1;
            int R_idx = right[i] - 1;

            long currentSubarraySum = prefixSums[R_idx + 1] - prefixSums[L_idx];

            maxProduct = Math.max(maxProduct, (long) nums[i] * currentSubarraySum);
        }

        long MOD = 1_000_000_007;
        return maxProduct % MOD;
    }
}