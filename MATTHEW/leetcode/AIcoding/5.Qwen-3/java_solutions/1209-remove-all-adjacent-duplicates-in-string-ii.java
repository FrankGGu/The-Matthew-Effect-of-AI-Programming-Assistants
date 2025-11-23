public class Solution {

import java.util.Stack;

public class Solution {
    public String removeDuplicates(String s, int k) {
        Stack<char[]> stack = new Stack<>();

        for (char c : s.toCharArray()) {
            if (!stack.isEmpty() && stack.peek()[0] == c) {
                stack.peek()[1]++;
                if (stack.peek()[1] == k) {
                    stack.pop();
                }
            } else {
                stack.push(new char[]{c, 1});
            }
        }

        StringBuilder result = new StringBuilder();
        while (!stack.isEmpty()) {
            char[] entry = stack.pop();
            for (int i = 0; i < entry[1]; i++) {
                result.append(entry[0]);
            }
        }

        return result.reverse().toString();
    }
}
}