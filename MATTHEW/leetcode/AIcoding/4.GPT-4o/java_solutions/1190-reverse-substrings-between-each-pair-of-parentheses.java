class Solution {
    public String reverseParentheses(String s) {
        Stack<String> stack = new Stack<>();
        StringBuilder current = new StringBuilder();

        for (char c : s.toCharArray()) {
            if (c == '(') {
                stack.push(current.toString());
                current = new StringBuilder();
            } else if (c == ')') {
                current.reverse();
                current.insert(0, stack.pop());
            } else {
                current.append(c);
            }
        }

        return current.toString();
    }
}