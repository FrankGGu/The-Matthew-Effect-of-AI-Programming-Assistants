class Solution {
    public String sortSentence(String s) {
        String[] words = s.split(" ");
        String[] sortedWords = new String[words.length];

        for (String word : words) {
            int index = word.charAt(word.length() - 1) - '0';
            sortedWords[index - 1] = word.substring(0, word.length() - 1);
        }

        return String.join(" ", sortedWords);
    }
}