import java.util.HashMap;

class Solution {
    public boolean isAlienSorted(String[] words, String order) {
        HashMap<Character, Integer> orderMap = new HashMap<>();
        for (int i = 0; i < order.length(); i++) {
            orderMap.put(order.charAt(i), i);
        }

        for (int i = 1; i < words.length; i++) {
            if (!isSorted(words[i - 1], words[i], orderMap)) {
                return false;
            }
        }
        return true;
    }

    private boolean isSorted(String word1, String word2, HashMap<Character, Integer> orderMap) {
        int minLength = Math.min(word1.length(), word2.length());
        for (int i = 0; i < minLength; i++) {
            char char1 = word1.charAt(i);
            char char2 = word2.charAt(i);
            if (char1 != char2) {
                return orderMap.get(char1) < orderMap.get(char2);
            }
        }
        return word1.length() <= word2.length();
    }
}