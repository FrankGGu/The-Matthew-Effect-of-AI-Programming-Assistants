import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;

class Solution {
    private Set<String> exactWords;
    private Map<String, String> lowerCaseMap;
    private Map<String, String> vowelNormalizedMap;

    public String[] spellchecker(String[] wordlist, String[] queries) {
        exactWords = new HashSet<>();
        lowerCaseMap = new HashMap<>();
        vowelNormalizedMap = new HashMap<>();

        for (String word : wordlist) {
            exactWords.add(word);
            String lower = word.toLowerCase();
            lowerCaseMap.putIfAbsent(lower, word);
            String normalized = normalizeVowels(lower);
            vowelNormalizedMap.putIfAbsent(normalized, word);
        }

        String[] results = new String[queries.length];
        for (int i = 0; i < queries.length; i++) {
            results[i] = resolveQuery(queries[i]);
        }
        return results;
    }

    private String resolveQuery(String query) {
        if (exactWords.contains(query)) {
            return query;
        }

        String lowerQuery = query.toLowerCase();
        if (lowerCaseMap.containsKey(lowerQuery)) {
            return lowerCaseMap.get(lowerQuery);
        }

        String normalizedQuery = normalizeVowels(lowerQuery);
        if (vowelNormalizedMap.containsKey(normalizedQuery)) {
            return vowelNormalizedMap.get(normalizedQuery);
        }

        return "";
    }

    private String normalizeVowels(String s) {
        char[] chars = s.toCharArray();
        for (int i = 0; i < chars.length; i++) {
            if (isVowel(chars[i])) {
                chars[i] = 'a';
            }
        }
        return new String(chars);
    }

    private boolean isVowel(char c) {
        return c == 'a' || c == 'e' || c == 'i' || c == 'o' || c == 'u';
    }
}