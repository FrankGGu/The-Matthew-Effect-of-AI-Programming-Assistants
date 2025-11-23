import java.util.HashMap;

class Solution {
    public String shortestCompletingWord(String licensePlate, String[] words) {
        HashMap<Character, Integer> plateCount = new HashMap<>();
        for (char c : licensePlate.toCharArray()) {
            if (Character.isLetter(c)) {
                c = Character.toLowerCase(c);
                plateCount.put(c, plateCount.getOrDefault(c, 0) + 1);
            }
        }

        String result = "";
        for (String word : words) {
            if (canComplete(word, plateCount)) {
                if (result.isEmpty() || word.length() < result.length()) {
                    result = word;
                }
            }
        }
        return result;
    }

    private boolean canComplete(String word, HashMap<Character, Integer> plateCount) {
        HashMap<Character, Integer> wordCount = new HashMap<>();
        for (char c : word.toCharArray()) {
            wordCount.put(c, wordCount.getOrDefault(c, 0) + 1);
        }
        for (char c : plateCount.keySet()) {
            if (wordCount.getOrDefault(c, 0) < plateCount.get(c)) {
                return false;
            }
        }
        return true;
    }
}