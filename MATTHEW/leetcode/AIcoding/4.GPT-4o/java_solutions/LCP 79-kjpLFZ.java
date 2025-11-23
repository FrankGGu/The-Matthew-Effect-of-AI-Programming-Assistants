import java.util.HashMap;
import java.util.Map;

class Solution {
    public boolean[] spellChecker(String[] wordlist, String[] queries) {
        Map<String, Integer> wordMap = new HashMap<>();
        Map<String, String> lowerMap = new HashMap<>();
        Map<String, String> vowelMap = new HashMap<>();

        for (String word : wordlist) {
            wordMap.put(word, wordMap.getOrDefault(word, 0) + 1);
            String lower = word.toLowerCase();
            lowerMap.putIfAbsent(lower, word);
            String vowelReplaced = lower.replaceAll("[aeiou]", "*");
            vowelMap.putIfAbsent(vowelReplaced, word);
        }

        boolean[] result = new boolean[queries.length];
        for (int i = 0; i < queries.length; i++) {
            String query = queries[i];
            if (wordMap.containsKey(query)) {
                result[i] = true;
            } else {
                String lowerQuery = query.toLowerCase();
                if (lowerMap.containsKey(lowerQuery)) {
                    result[i] = true;
                } else {
                    String vowelReplacedQuery = lowerQuery.replaceAll("[aeiou]", "*");
                    if (vowelMap.containsKey(vowelReplacedQuery)) {
                        result[i] = true;
                    }
                }
            }
        }
        return result;
    }
}