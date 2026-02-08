public class Solution {

import java.util.*;

public class Solution {
    public String[] spellchecker(String[] wordList, String[] queries) {
        Set<String> words = new HashSet<>(Arrays.asList(wordList));
        Map<String, String> vowelMap = new HashMap<>();
        Map<String, String> caseMap = new HashMap<>();

        for (String word : wordList) {
            String lower = word.toLowerCase();
            String vowel = replaceVowels(lower);
            if (!caseMap.containsKey(lower)) {
                caseMap.put(lower, word);
            }
            if (!vowelMap.containsKey(vowel)) {
                vowelMap.put(vowel, word);
            }
        }

        String[] result = new String[queries.length];
        for (int i = 0; i < queries.length; i++) {
            String q = queries[i];
            String lower = q.toLowerCase();
            String vowel = replaceVowels(lower);
            if (words.contains(q)) {
                result[i] = q;
            } else if (caseMap.containsKey(lower)) {
                result[i] = caseMap.get(lower);
            } else if (vowelMap.containsKey(vowel)) {
                result[i] = vowelMap.get(vowel);
            } else {
                result[i] = "";
            }
        }
        return result;
    }

    private String replaceVowels(String s) {
        StringBuilder sb = new StringBuilder();
        for (char c : s.toCharArray()) {
            if (c == 'a' || c == 'e' || c == 'i' || c == 'o' || c == 'u') {
                sb.append('*');
            } else {
                sb.append(c);
            }
        }
        return sb.toString();
    }
}
}