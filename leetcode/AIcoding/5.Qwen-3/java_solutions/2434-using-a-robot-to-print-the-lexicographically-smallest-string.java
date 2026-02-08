public class Solution {

import java.util.*;

public class Solution {
    public String robotWithString(String s) {
        int[] nextSmaller = new int[s.length()];
        Arrays.fill(nextSmaller, -1);
        Stack<Integer> stack = new Stack<>();

        for (int i = s.length() - 1; i >= 0; i--) {
            while (!stack.isEmpty() && s.charAt(stack.peek()) > s.charAt(i)) {
                stack.pop();
            }
            if (!stack.isEmpty()) {
                nextSmaller[i] = stack.peek();
            }
            stack.push(i);
        }

        StringBuilder result = new StringBuilder();
        Stack<Character> temp = new Stack<>();

        for (int i = 0; i < s.length(); i++) {
            temp.push(s.charAt(i));
            while (!temp.isEmpty() && (nextSmaller[i] == -1 || temp.peek() <= s.charAt(nextSmaller[i]))) {
                result.append(temp.pop());
            }
        }

        while (!temp.isEmpty()) {
            result.append(temp.pop());
        }

        return result.toString();
    }
}
}