import java.util.*;

public class Solution {
    public boolean isAlienSorted(String[] words, String order) {
        Map<Character, Integer> orderMap = new HashMap<>();
        for (int i = 0; i < order.length(); i++) {
            orderMap.put(order.charAt(i), i);
        }

        for (int i = 1; i < words.length; i++) {
            if (!isInOrder(words[i - 1], words[i], orderMap)) {
                return false;
            }
        }

        return true;
    }

    private boolean isInOrder(String word1, String word2, Map<Character, Integer> orderMap) {
        int minLength = Math.min(word1.length(), word2.length());
        for (int i = 0; i < minLength; i++) {
            char c1 = word1.charAt(i);
            char c2 = word2.charAt(i);
            if (c1 != c2) {
                return orderMap.get(c1) < orderMap.get(c2);
            }
        }
        return word1.length() <= word2.length();
    }
}