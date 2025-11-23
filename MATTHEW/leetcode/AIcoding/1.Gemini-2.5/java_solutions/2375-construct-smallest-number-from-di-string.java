import java.util.Stack;

class Solution {
    public String smallestNumber(String pattern) {
        int n = pattern.length();
        char[] result = new char[n + 1];
        Stack<Integer> stack = new Stack<>();
        int currentDigit = 1;
        int resultIndex = 0;

        for (int i = 0; i <= n; i++) {
            stack.push(currentDigit);
            currentDigit++;

            if (i == n || pattern.charAt(i) == 'I') {
                while (!stack.isEmpty()) {
                    result[resultIndex++] = (char)(stack.pop() + '0');
                }
            }
        }

        return new String(result);
    }
}