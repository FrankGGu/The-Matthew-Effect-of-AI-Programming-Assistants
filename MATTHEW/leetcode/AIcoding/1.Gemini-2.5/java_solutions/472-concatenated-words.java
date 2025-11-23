import java.util.ArrayList;
import java.util.Collections;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

class Solution {
    public List<String> findAllConcatenatedWordsInADict(String[] words) {
        List<String> result = new ArrayList<>();
        if (words == null || words.length == 0) {
            return result;
        }

        List<String> validWords = new ArrayList<>();
        for (String word : words) {
            if (!word.isEmpty()) {
                validWords.add(word);
            }
        }

        Collections.sort(validWords, (a, b) -> a.length() - b.length());

        Set<String> preWords = new HashSet<>();

        for (String word : validWords) {
            if (preWords.isEmpty()) {
                preWords.add(word);
                continue;
            }

            if (canBreak(word, preWords)) {
                result.add(word);
            }
            preWords.add(word);
        }

        return result;
    }

    private boolean canBreak(String s, Set<String> dictionary) {
        if (s.isEmpty()) {
            return false;
        }

        boolean[] dp = new boolean[s.length() + 1];
        dp[0] = true;

        for (int i = 1; i <= s.length(); i++) {
            for (int j = 0; j < i; j++) {
                if (dp[j] && dictionary.contains(s.substring(j, i))) {
                    dp[i] = true;
                    break; 
                }
            }
        }
        return dp[s.length()];
    }
}