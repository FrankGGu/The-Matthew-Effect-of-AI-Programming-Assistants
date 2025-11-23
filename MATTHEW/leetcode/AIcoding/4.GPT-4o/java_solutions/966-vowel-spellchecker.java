import java.util.*;

public class Solution {
    public String[] spellchecker(String[] wordlist, String[] queries) {
        Set<String> wordSet = new HashSet<>(Arrays.asList(wordlist));
        Map<String, String> capitalizationMap = new HashMap<>();
        Map<String, String> vowelMap = new HashMap<>();

        String vowels = "aeiou";

        for (String word : wordlist) {
            capitalizationMap.putIfAbsent(word.toLowerCase(), word);
            String vowelWord = word.replaceAll("[aeiou]", "#");
            vowelMap.putIfAbsent(vowelWord, word);
        }

        String[] results = new String[queries.length];

        for (int i = 0; i < queries.length; i++) {
            String query = queries[i];
            if (wordSet.contains(query)) {
                results[i] = query;
            } else if (capitalizationMap.containsKey(query.toLowerCase())) {
                results[i] = capitalizationMap.get(query.toLowerCase());
            } else {
                String vowelQuery = query.replaceAll("[aeiou]", "#");
                results[i] = vowelMap.getOrDefault(vowelQuery, "");
            }
        }

        return results;
    }
}