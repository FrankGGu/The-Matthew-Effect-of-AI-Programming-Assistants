import java.util.ArrayList;
import java.util.List;

class Solution {
    public List<String> removeAnagrams(String[] words) {
        List<String> result = new ArrayList<>();
        if (words == null || words.length == 0) {
            return result;
        }

        result.add(words[0]);

        for (int i = 1; i < words.length; i++) {
            String currentWord = words[i];
            String lastAddedWord = result.get(result.size() - 1);

            if (!areAnagrams(currentWord, lastAddedWord)) {
                result.add(currentWord);
            }
        }

        return result;
    }

    private boolean areAnagrams(String s1, String s2) {
        if (s1.length() != s2.length()) {
            return false;
        }

        int[] freq = new int[26]; // For lowercase English letters

        for (char c : s1.toCharArray()) {
            freq[c - 'a']++;
        }

        for (char c : s2.toCharArray()) {
            freq[c - 'a']--;
        }

        for (int count : freq) {
            if (count != 0) {
                return false;
            }
        }

        return true;
    }
}