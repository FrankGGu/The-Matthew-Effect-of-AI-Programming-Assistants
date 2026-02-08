public class Solution {

import java.util.Stack;

public class Solution {
    public String removeKDigits(String num, int k) {
        Stack<Character> stack = new Stack<>();
        for (char c : num.toCharArray()) {
            while (k > 0 && !stack.isEmpty() && stack.peek() > c) {
                stack.pop();
                k--;
            }
            stack.push(c);
        }
        while (k > 0) {
            stack.pop();
            k--;
        }
        StringBuilder sb = new StringBuilder();
        while (!stack.isEmpty()) {
            sb.append(stack.pop());
        }
        String result = sb.reverse().toString();
        int i = 0;
        while (i < result.length() && result.charAt(i) == '0') {
            i++;
        }
        return i == result.length() ? "0" : result.substring(i);
    }
}
}