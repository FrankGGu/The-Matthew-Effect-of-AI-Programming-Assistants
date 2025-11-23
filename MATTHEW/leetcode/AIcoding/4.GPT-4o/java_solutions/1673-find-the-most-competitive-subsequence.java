import java.util.Stack;

public class Solution {
    public int[] mostCompetitive(int[] nums, int k) {
        Stack<Integer> stack = new Stack<>();
        int toPop = nums.length - k;

        for (int num : nums) {
            while (!stack.isEmpty() && toPop > 0 && stack.peek() > num) {
                stack.pop();
                toPop--;
            }
            stack.push(num);
        }

        while (toPop > 0) {
            stack.pop();
            toPop--;
        }

        int[] result = new int[k];
        for (int i = k - 1; i >= 0; i--) {
            result[i] = stack.pop();
        }

        return result;
    }
}