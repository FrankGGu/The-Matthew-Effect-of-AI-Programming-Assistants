import java.util.HashMap;

class Solution {
    public int countCharacters(String[] words, String chars) {
        HashMap<Character, Integer> charCount = new HashMap<>();
        for (char c : chars.toCharArray()) {
            charCount.put(c, charCount.getOrDefault(c, 0) + 1);
        }

        int totalLength = 0;
        for (String word : words) {
            HashMap<Character, Integer> wordCount = new HashMap<>();
            for (char c : word.toCharArray()) {
                wordCount.put(c, wordCount.getOrDefault(c, 0) + 1);
            }
            boolean canForm = true;
            for (char c : wordCount.keySet()) {
                if (wordCount.get(c) > charCount.getOrDefault(c, 0)) {
                    canForm = false;
                    break;
                }
            }
            if (canForm) {
                totalLength += word.length();
            }
        }
        return totalLength;
    }
}