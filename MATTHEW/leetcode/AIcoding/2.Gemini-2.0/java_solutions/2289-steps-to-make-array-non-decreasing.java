import java.util.Stack;

class Solution {
    public int totalSteps(int[] nums) {
        int n = nums.length;
        int[] dp = new int[n];
        Stack<Integer> stack = new Stack<>();
        int ans = 0;
        for (int i = n - 1; i >= 0; i--) {
            while (!stack.isEmpty() && nums[i] > nums[stack.peek()]) {
                dp[i] = Math.max(dp[i] + 1, dp[stack.peek()]);
                stack.pop();
            }
            ans = Math.max(ans, dp[i]);
            stack.push(i);
        }
        return ans;
    }
}