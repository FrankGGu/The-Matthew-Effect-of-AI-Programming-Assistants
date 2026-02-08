class Solution {
    public String reverseParentheses(String s) {
        Stack<StringBuilder> stack = new Stack<>();
        stack.push(new StringBuilder());

        for (char c : s.toCharArray()) {
            if (c == '(') {
                stack.push(new StringBuilder());
            } else if (c == ')') {
                StringBuilder popped = stack.pop();
                stack.peek().append(popped.reverse());
            } else {
                stack.peek().append(c);
            }
        }

        return stack.pop().toString();
    }
}