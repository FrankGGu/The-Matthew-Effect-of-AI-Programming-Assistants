import java.util.Stack;

class Solution {
    public boolean isValid(String s) {
        Stack<Character> stack = new Stack<>();

        for (char c : s.toCharArray()) {
            if (c == 'a' || c == 'b') {
                stack.push(c);
            } else if (c == 'c') {
                if (stack.size() < 2 || stack.pop() != 'b' || stack.pop() != 'a') {
                    return false;
                }
            }
        }

        return stack.isEmpty();
    }
}