class Solution {
    public String reverseWords(String s) {
        String[] words = s.split(" ");
        StringBuilder result = new StringBuilder();

        for (int i = 0; i < words.length; i++) {
            StringBuilder wordBuilder = new StringBuilder(words[i]);
            wordBuilder.reverse();
            result.append(wordBuilder);
            if (i < words.length - 1) {
                result.append(" ");
            }
        }
        return result.toString();
    }
}