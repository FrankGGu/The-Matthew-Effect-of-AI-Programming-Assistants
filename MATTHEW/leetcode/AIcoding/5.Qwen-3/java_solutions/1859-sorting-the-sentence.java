public class Solution {
    public String sortSentence(String s) {
        String[] words = s.split(" ");
        String[] result = new String[words.length];

        for (String word : words) {
            int index = Integer.parseInt(word.substring(word.length() - 1));
            result[index - 1] = word.substring(0, word.length() - 1);
        }

        return String.join(" ", result);
    }
}