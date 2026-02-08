public class Solution {
    public String capitalizeTitle(String title) {
        StringBuilder result = new StringBuilder();
        String[] words = title.split(" ");
        for (int i = 0; i < words.length; i++) {
            String word = words[i];
            if (word.length() <= 2) {
                result.append(word.toLowerCase());
            } else {
                result.append(Character.toUpperCase(word.charAt(0))).append(word.substring(1).toLowerCase());
            }
            if (i < words.length - 1) {
                result.append(" ");
            }
        }
        return result.toString();
    }
}