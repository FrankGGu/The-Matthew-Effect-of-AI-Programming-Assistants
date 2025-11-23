import java.util.*;

class Solution {
    public String robotWithString(String s) {
        int n = s.length();
        int[] suffixMin = new int[n];
        suffixMin[n - 1] = s.charAt(n - 1) - 'a';
        for (int i = n - 2; i >= 0; i--) {
            suffixMin[i] = Math.min(suffixMin[i + 1], s.charAt(i) - 'a');
        }

        StringBuilder result = new StringBuilder();
        Stack<Character> stack = new Stack<>();
        for (int i = 0; i < n; i++) {
            stack.push(s.charAt(i));
            while (!stack.isEmpty() && stack.peek() - 'a' <= suffixMin[i]) {
                result.append(stack.pop());
            }
        }

        while (!stack.isEmpty()) {
            result.append(stack.pop());
        }

        return result.toString();
    }
}