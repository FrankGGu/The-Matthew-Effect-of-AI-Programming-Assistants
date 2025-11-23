import java.util.Stack;

public class Solution {
    public String removeDuplicateLetters(String s) {
        int[] lastIndex = new int[26];
        boolean[] inResult = new boolean[26];
        StringBuilder result = new StringBuilder();

        for (int i = 0; i < s.length(); i++) {
            lastIndex[s.charAt(i) - 'a'] = i;
        }

        for (int i = 0; i < s.length(); i++) {
            char current = s.charAt(i);
            if (inResult[current - 'a']) continue;

            while (result.length() > 0 && result.charAt(result.length() - 1) > current && lastIndex[result.charAt(result.length() - 1) - 'a'] > i) {
                inResult[result.charAt(result.length() - 1) - 'a'] = false;
                result.deleteCharAt(result.length() - 1);
            }

            result.append(current);
            inResult[current - 'a'] = true;
        }

        return result.toString();
    }
}