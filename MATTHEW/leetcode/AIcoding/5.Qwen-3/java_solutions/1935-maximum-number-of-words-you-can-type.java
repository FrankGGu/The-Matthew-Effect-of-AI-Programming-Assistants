public class Solution {
    public int canBeTypedWords(String[] text, String brokenLetters) {
        int count = 0;
        for (String word : text) {
            boolean canType = true;
            for (char c : brokenLetters.toCharArray()) {
                if (word.indexOf(c) >= 0) {
                    canType = false;
                    break;
                }
            }
            if (canType) count++;
        }
        return count;
    }
}