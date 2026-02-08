class Solution {
    public int scoreOfParentheses(String s) {
        Stack<Integer> stack = new Stack<>();
        stack.push(0);

        for (char c : s.toCharArray()) {
            if (c == '(') {
                stack.push(0);
            } else {
                int top = stack.pop();
                int val = stack.pop();
                stack.push(val + Math.max(2 * top, 1));
            }
        }

        return stack.pop();
    }
}