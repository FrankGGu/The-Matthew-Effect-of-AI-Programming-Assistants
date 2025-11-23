import java.util.ArrayList;
import java.util.List;

class Solution {
    public List<String> wordSubsets(String[] words1, String[] words2) {
        int[] target = new int[26];
        for (String word : words2) {
            int[] count = new int[26];
            for (char c : word.toCharArray()) {
                count[c - 'a']++;
            }
            for (int i = 0; i < 26; i++) {
                target[i] = Math.max(target[i], count[i]);
            }
        }

        List<String> result = new ArrayList<>();
        for (String word : words1) {
            int[] count = new int[26];
            for (char c : word.toCharArray()) {
                count[c - 'a']++;
            }
            boolean valid = true;
            for (int i = 0; i < 26; i++) {
                if (count[i] < target[i]) {
                    valid = false;
                    break;
                }
            }
            if (valid) {
                result.add(word);
            }
        }

        return result;
    }
}