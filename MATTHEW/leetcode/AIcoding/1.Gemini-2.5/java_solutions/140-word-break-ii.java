import java.util.List;
import java.util.ArrayList;
import java.util.Set;
import java.util.HashSet;
import java.util.Map;
import java.util.HashMap;

class Solution {
    public List<String> wordBreak(String s, List<String> wordDict) {
        Set<String> wordSet = new HashSet<>(wordDict);
        Map<String, List<String>> memo = new HashMap<>();
        return backtrack(s, wordSet, memo);
    }

    private List<String> backtrack(String s, Set<String> wordSet, Map<String, List<String>> memo) {
        if (memo.containsKey(s)) {
            return memo.get(s);
        }

        List<String> result = new ArrayList<>();
        if (s.isEmpty()) {
            result.add("");
            return result;
        }

        for (int i = 1; i <= s.length(); i++) {
            String word = s.substring(0, i);
            if (wordSet.contains(word)) {
                List<String> subSentences = backtrack(s.substring(i), wordSet, memo);
                for (String subSentence : subSentences) {
                    if (subSentence.isEmpty()) {
                        result.add(word);
                    } else {
                        result.add(word + " " + subSentence);
                    }
                }
            }
        }

        memo.put(s, result);
        return result;
    }
}