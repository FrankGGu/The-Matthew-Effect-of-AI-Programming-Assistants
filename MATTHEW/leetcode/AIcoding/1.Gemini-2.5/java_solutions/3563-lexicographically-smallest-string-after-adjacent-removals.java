import java.util.Deque;
import java.util.ArrayDeque;

class Solution {
    public String makeSmallestString(String s) {
        Deque<Character> stack = new ArrayDeque<>();

        for (char c : s.toCharArray()) {
            while (!stack.isEmpty() && stack.peekLast() > c) {
                stack.removeLast();
            }
            stack.addLast(c);
        }

        StringBuilder sb = new StringBuilder();
        for (char c : stack) {
            sb.append(c);
        }

        return sb.toString();
    }
}