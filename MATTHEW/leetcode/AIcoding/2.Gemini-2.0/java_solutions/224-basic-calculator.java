import java.util.Stack;

class Solution {
    public int calculate(String s) {
        int sign = 1;
        int res = 0;
        Stack<Integer> stack = new Stack<>();
        stack.push(sign);

        for (int i = 0; i < s.length(); i++) {
            char c = s.charAt(i);

            if (Character.isDigit(c)) {
                int num = 0;
                while (i < s.length() && Character.isDigit(s.charAt(i))) {
                    num = num * 10 + (s.charAt(i) - '0');
                    i++;
                }
                i--;
                res += num * sign;
            } else if (c == '+') {
                sign = stack.peek();
            } else if (c == '-') {
                sign = -stack.peek();
            } else if (c == '(') {
                stack.push(sign);
            } else if (c == ')') {
                stack.pop();
            }
        }

        return res;
    }
}