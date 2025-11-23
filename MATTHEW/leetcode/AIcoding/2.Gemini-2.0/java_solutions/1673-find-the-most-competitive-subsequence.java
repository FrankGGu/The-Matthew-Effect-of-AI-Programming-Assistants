import java.util.Stack;

class Solution {
    public int[] mostCompetitive(int[] nums, int k) {
        Stack<Integer> stack = new Stack<>();
        int n = nums.length;
        for (int i = 0; i < n; i++) {
            while (!stack.isEmpty() && nums[i] < nums[stack.peek()] && n - i + stack.size() > k) {
                stack.pop();
            }
            if (stack.size() < k) {
                stack.push(i);
            }
        }
        int[] result = new int[k];
        for (int i = k - 1; i >= 0; i--) {
            result[i] = nums[stack.pop()];
        }
        return result;
    }
}