public class Solution {

import java.util.Stack;

public class Solution {
    public int sumSubarrayMins(int[] nums) {
        int MOD = 1000000007;
        int n = nums.length;
        int[] left = new int[n];
        int[] right = new int[n];

        Stack<Integer> stack = new Stack<>();

        for (int i = 0; i < n; i++) {
            int count = 1;
            while (!stack.isEmpty() && nums[stack.peek()] > nums[i]) {
                count += left[stack.pop()];
            }
            left[i] = count;
            stack.push(i);
        }

        stack.clear();

        for (int i = n - 1; i >= 0; i--) {
            int count = 1;
            while (!stack.isEmpty() && nums[stack.peek()] >= nums[i]) {
                count += right[stack.pop()];
            }
            right[i] = count;
            stack.push(i);
        }

        int result = 0;
        for (int i = 0; i < n; i++) {
            result = (result + nums[i] * left[i] * right[i]) % MOD;
        }

        return result;
    }
}
}