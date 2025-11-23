import java.util.Stack;

class Solution {
    public boolean find132pattern(int[] nums) {
        if (nums.length < 3) {
            return false;
        }

        Stack<Integer> stack = new Stack<>();
        int k_val = Integer.MIN_VALUE;

        for (int i = nums.length - 1; i >= 0; i--) {
            if (nums[i] < k_val) {
                return true;
            }

            while (!stack.isEmpty() && nums[i] > stack.peek()) {
                k_val = stack.pop();
            }

            stack.push(nums[i]);
        }

        return false;
    }
}