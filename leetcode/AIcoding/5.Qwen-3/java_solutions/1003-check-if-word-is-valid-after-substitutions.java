public class Solution {
    public boolean isValid(String s) {
        java.util.Stack<Character> stack = new java.util.Stack<>();
        for (char c : s.toCharArray()) {
            if (c == 'a') {
                stack.push(c);
            } else if (c == 'b') {
                if (!stack.isEmpty() && stack.peek() == 'a') {
                    stack.pop();
                    stack.push('b');
                } else {
                    return false;
                }
            } else if (c == 'c') {
                if (!stack.isEmpty() && stack.peek() == 'b') {
                    stack.pop();
                } else {
                    return false;
                }
            } else {
                return false;
            }
        }
        return stack.isEmpty();
    }
}