import java.util.Stack;

class Solution {
    public NestedInteger deserialize(String s) {
        if (s.charAt(0) != '[') {
            return new NestedInteger(Integer.parseInt(s));
        }

        Stack<NestedInteger> stack = new Stack<>();
        NestedInteger current = null;
        int i = 0;

        while (i < s.length()) {
            char c = s.charAt(i);
            if (c == '[') {
                if (current != null) {
                    stack.push(current);
                }
                current = new NestedInteger();
                i++;
            } else if (c == ']') {
                if (!stack.isEmpty()) {
                    NestedInteger prev = stack.pop();
                    prev.add(current);
                    current = prev;
                }
                i++;
            } else if (c == ',') {
                i++;
            } else { // Must be a digit or '-'
                int start = i;
                if (c == '-') {
                    i++;
                }
                while (i < s.length() && Character.isDigit(s.charAt(i))) {
                    i++;
                }
                int value = Integer.parseInt(s.substring(start, i));
                current.add(new NestedInteger(value));
            }
        }
        return current;
    }
}