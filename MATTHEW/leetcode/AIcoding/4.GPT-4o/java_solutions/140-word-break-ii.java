import java.util.*;

public class Solution {
    public List<String> wordBreak(String s, List<String> wordDict) {
        Set<String> wordSet = new HashSet<>(wordDict);
        List<String> result = new ArrayList<>();
        backtrack(s, wordSet, new StringBuilder(), result, 0);
        return result;
    }

    private void backtrack(String s, Set<String> wordSet, StringBuilder current, List<String> result, int start) {
        if (start == s.length()) {
            result.add(current.toString().trim());
            return;
        }
        for (int end = start + 1; end <= s.length(); end++) {
            String word = s.substring(start, end);
            if (wordSet.contains(word)) {
                int len = current.length();
                current.append(word).append(" ");
                backtrack(s, wordSet, current, result, end);
                current.setLength(len);
            }
        }
    }
}