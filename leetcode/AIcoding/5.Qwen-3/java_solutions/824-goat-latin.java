public class Solution {
    public String toGoatLatin(String sentence) {
        StringBuilder result = new StringBuilder();
        String[] words = sentence.split(" ");
        for (int i = 0; i < words.length; i++) {
            String word = words[i];
            char firstChar = Character.toLowerCase(word.charAt(0));
            if (firstChar == 'a' || firstChar == 'e' || firstChar == 'i' || firstChar == 'o' || firstChar == 'u') {
                result.append(word).append("ma");
            } else {
                result.append(word.substring(1)).append(word.charAt(0)).append("ma");
            }
            for (int j = 0; j <= i; j++) {
                result.append("a");
            }
            if (i != words.length - 1) {
                result.append(" ");
            }
        }
        return result.toString();
    }
}