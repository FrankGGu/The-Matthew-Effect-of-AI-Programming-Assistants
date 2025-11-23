import java.util.Arrays;
import java.util.HashSet;
import java.util.Set;

class Solution {
    public String[] spellchecker(String[] wordlist, String[] queries) {
        Set<String> words = new HashSet<>(Arrays.asList(wordlist));
        String[] res = new String[queries.length];
        for (int i = 0; i < queries.length; i++) {
            String query = queries[i];
            if (words.contains(query)) {
                res[i] = query;
                continue;
            }
            String lower = query.toLowerCase();
            String bestLower = null;
            String bestVowel = null;
            for (String word : wordlist) {
                String wordLower = word.toLowerCase();
                if (wordLower.equals(lower)) {
                    if (bestLower == null) {
                        bestLower = word;
                    }
                }
            }
            if (bestLower != null) {
                res[i] = bestLower;
                continue;
            }
            String vowel = toVowel(lower);
            for (String word : wordlist) {
                String wordLower = word.toLowerCase();
                if (toVowel(wordLower).equals(vowel)) {
                    if (bestVowel == null) {
                        bestVowel = word;
                    }
                }
            }
            if (bestVowel != null) {
                res[i] = bestVowel;
            } else {
                res[i] = "";
            }
        }
        return res;
    }

    private String toVowel(String s) {
        StringBuilder sb = new StringBuilder();
        for (char c : s.toCharArray()) {
            if (c == 'a' || c == 'e' || c == 'i' || c == 'o' || c == 'u') {
                sb.append('#');
            } else {
                sb.append(c);
            }
        }
        return sb.toString();
    }
}