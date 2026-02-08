public class Solution {
    public int calculate(String s) {
        int result = 0;
        int currentNumber = 0;
        int sign = 1;
        int n = s.length();
        for (int i = 0; i < n; i++) {
            char c = s.charAt(i);
            if (Character.isDigit(c)) {
                currentNumber = currentNumber * 10 + (c - '0');
            } else if (c == '+') {
                result += sign * currentNumber;
                currentNumber = 0;
                sign = 1;
            } else if (c == '-') {
                result += sign * currentNumber;
                currentNumber = 0;
                sign = -1;
            } else if (c == '(') {
                result += sign * currentNumber;
                currentNumber = 0;
                sign = 1;
            } else if (c == ')') {
                result += sign * currentNumber;
                currentNumber = 0;
                sign = 1;
            }
        }
        result += sign * currentNumber;
        return result;
    }
}