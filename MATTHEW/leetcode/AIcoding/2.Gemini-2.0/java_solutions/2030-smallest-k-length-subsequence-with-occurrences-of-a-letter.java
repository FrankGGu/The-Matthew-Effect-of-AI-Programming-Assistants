import java.util.ArrayDeque;
import java.util.Deque;

class Solution {
    public String smallestSubsequence(String s, int k, char letter, int repetition) {
        int n = s.length();
        int letterCount = 0;
        for (char c : s.toCharArray()) {
            if (c == letter) {
                letterCount++;
            }
        }

        Deque<Character> stack = new ArrayDeque<>();
        for (int i = 0; i < n; i++) {
            char c = s.charAt(i);
            while (!stack.isEmpty() && c < stack.peekLast() &&
                    (n - i + stack.size() > k) &&
                    ((stack.peekLast() != letter && letterCount >= repetition) ||
                     (stack.peekLast() == letter && letterCount > repetition))) {
                char removed = stack.pollLast();
                if (removed == letter) {
                    repetition++;
                }
            }

            if (stack.size() < k) {
                if (c == letter) {
                    stack.offerLast(c);
                    repetition--;
                } else if (k - stack.size() > repetition) {
                    stack.offerLast(c);
                }
            }

            if (c == letter) {
                letterCount--;
            }
        }

        StringBuilder sb = new StringBuilder();
        while (!stack.isEmpty()) {
            sb.append(stack.pollFirst());
        }

        return sb.toString();
    }
}