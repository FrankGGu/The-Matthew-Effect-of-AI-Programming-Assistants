public class Solution {

import java.util.*;

public class Solution {
    public String reverseParentheses(String s) {
        Stack<Character> stack = new Stack<>();
        List<Character> result = new ArrayList<>();

        for (char c : s.toCharArray()) {
            if (c == '(') {
                stack.push('(');
            } else if (c == ')') {
                List<Character> temp = new ArrayList<>();
                while (!stack.isEmpty() && stack.peek() != '(') {
                    temp.add(stack.pop());
                }
                stack.pop(); // Remove the '('
                for (char ch : temp) {
                    stack.push(ch);
                }
            } else {
                stack.push(c);
            }
        }

        while (!stack.isEmpty()) {
            result.add(stack.pop());
        }

        StringBuilder sb = new StringBuilder();
        for (char c : result) {
            sb.append(c);
        }

        return sb.toString();
    }
}
}