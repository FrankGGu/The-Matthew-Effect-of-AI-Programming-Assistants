import java.util.Stack;

class Solution {
    public String smallestSubsequence(String s, int k, char letter, int repetition) {
        int n = s.length();
        Stack<Character> stack = new Stack<>();
        int letterCount = 0, toRemove = n - k;

        for (char c : s.toCharArray()) {
            while (!stack.isEmpty() && toRemove > 0 && stack.peek() > c && 
                   (stack.peek() != letter || letterCount + (c == letter ? 1 : 0) < repetition)) {
                if (stack.peek() == letter) letterCount--;
                stack.pop();
                toRemove--;
            }
            if (stack.size() < k) {
                if (c == letter) {
                    stack.push(c);
                    letterCount++;
                } else if (stack.size() < k - repetition || letterCount < repetition) {
                    stack.push(c);
                }
            }
            if (c == letter) letterCount++;
        }

        StringBuilder result = new StringBuilder();
        for (char c : stack) {
            result.append(c);
        }

        return result.toString();
    }
}