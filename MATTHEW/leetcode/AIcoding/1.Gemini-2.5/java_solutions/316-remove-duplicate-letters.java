import java.util.ArrayDeque;
import java.util.Deque;

class Solution {
    public String removeDuplicateLetters(String s) {
        int[] lastIndex = new int[26];
        for (int i = 0; i < s.length(); i++) {
            lastIndex[s.charAt(i) - 'a'] = i;
        }

        boolean[] inStack = new boolean[26];
        Deque<Character> stack = new ArrayDeque<>();

        for (int i = 0; i < s.length(); i++) {
            char c = s.charAt(i);
            if (inStack[c - 'a']) {
                continue;
            }

            while (!stack.isEmpty() && c < stack.peekLast() && lastIndex[stack.peekLast() - 'a'] > i) {
                char popped = stack.removeLast();
                inStack[popped - 'a'] = false;
            }

            stack.addLast(c);
            inStack[c - 'a'] = true;
        }

        StringBuilder sb = new StringBuilder();
        for (char c : stack) {
            sb.append(c);
        }

        return sb.toString();
    }
}