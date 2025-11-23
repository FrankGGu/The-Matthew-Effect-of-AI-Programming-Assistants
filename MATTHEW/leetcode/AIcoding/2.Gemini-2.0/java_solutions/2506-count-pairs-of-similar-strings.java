import java.util.HashSet;
import java.util.Set;

class Solution {
    public int similarPairs(String[] words) {
        int count = 0;
        for (int i = 0; i < words.length; i++) {
            for (int j = i + 1; j < words.length; j++) {
                if (areSimilar(words[i], words[j])) {
                    count++;
                }
            }
        }
        return count;
    }

    private boolean areSimilar(String word1, String word2) {
        Set<Character> set1 = new HashSet<>();
        Set<Character> set2 = new HashSet<>();

        for (char c : word1.toCharArray()) {
            set1.add(c);
        }
        for (char c : word2.toCharArray()) {
            set2.add(c);
        }

        return set1.equals(set2);
    }
}