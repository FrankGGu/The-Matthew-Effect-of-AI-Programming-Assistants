public class Solution {

import java.util.*;

public class Solution {
    public List<String> wordBreak(String s, List<String> wordDict) {
        return helper(s, new HashSet<String>(wordDict), 0, new HashMap<Integer, List<String>>());
    }

    private List<String> helper(String s, Set<String> wordSet, int start, Map<Integer, List<String>> memo) {
        if (memo.containsKey(start)) {
            return memo.get(start);
        }
        List<String> result = new ArrayList<>();
        if (start == s.length()) {
            result.add("");
            return result;
        }
        for (int end = start + 1; end <= s.length(); end++) {
            String word = s.substring(start, end);
            if (wordSet.contains(word)) {
                List<String> nextList = helper(s, wordSet, end, memo);
                for (String next : nextList) {
                    result.add(word + (next.isEmpty() ? "" : " ") + next);
                }
            }
        }
        memo.put(start, result);
        return result;
    }
}
}