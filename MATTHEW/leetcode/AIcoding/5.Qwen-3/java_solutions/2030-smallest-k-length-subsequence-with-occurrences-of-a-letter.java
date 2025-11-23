public class Solution {

import java.util.*;

public class Solution {
    public String smallestSubsequence(String s, int k, char letter, int minOccurrences) {
        int n = s.length();
        int required = minOccurrences;
        int count = 0;
        Stack<Character> stack = new Stack<>();
        for (int i = 0; i < n; i++) {
            char c = s.charAt(i);
            while (!stack.isEmpty() && stack.peek() > c && (n - i + stack.size() - 1) >= k) {
                if (stack.peek() == letter) {
                    count--;
                }
                stack.pop();
            }
            if (c == letter) {
                count++;
            }
            stack.push(c);
        }
        while (stack.size() > k) {
            if (stack.peek() == letter) {
                count--;
            }
            stack.pop();
        }
        StringBuilder sb = new StringBuilder();
        for (char c : stack) {
            sb.append(c);
        }
        return sb.toString();
    }
}
}