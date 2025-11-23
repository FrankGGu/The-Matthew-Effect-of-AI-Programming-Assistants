import java.util.Stack;

class Solution {
    public String removeDuplicates(String s, int k) {
        Stack<int[]> stack = new Stack<>(); // int[0] = character (as int), int[1] = count

        for (char c : s.toCharArray()) {
            if (!stack.isEmpty() && stack.peek()[0] == c) {
                stack.peek()[1]++;
            } else {
                stack.push(new int[]{c, 1});
            }

            if (stack.peek()[1] == k) {
                stack.pop();
            }
        }

        StringBuilder sb = new StringBuilder();
        for (int[] entry : stack) {
            char character = (char) entry[0];
            int count = entry[1];
            for (int i = 0; i < count; i++) {
                sb.append(character);
            }
        }

        return sb.toString();
    }
}