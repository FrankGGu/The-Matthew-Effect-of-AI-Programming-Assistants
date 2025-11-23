public class Solution {

import java.util.*;

public class Solution {
    public String removeDuplicateLetters(String s) {
        Stack<Character> stack = new Stack<>();
        HashSet<Character> seen = new HashSet<>();
        int[] lastOccurrence = new int[26];

        for (int i = 0; i < s.length(); i++) {
            lastOccurrence[s.charAt(i) - 'a'] = i;
        }

        for (int i = 0; i < s.length(); i++) {
            char c = s.charAt(i);
            if (seen.contains(c)) {
                continue;
            }
            while (!stack.isEmpty() && c < stack.peek() && lastOccurrence[stack.peek() - 'a'] > i) {
                seen.remove(stack.pop());
            }
            seen.add(c);
            stack.push(c);
        }

        StringBuilder result = new StringBuilder();
        while (!stack.isEmpty()) {
            result.append(stack.pop());
        }
        return result.reverse().toString();
    }
}
}