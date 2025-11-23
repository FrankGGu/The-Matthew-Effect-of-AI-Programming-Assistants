class Solution {
    public int mostWordsFound(String[] sentences) {
        int maxWords = 0;
        for (String sentence : sentences) {
            String[] words = sentence.split(" ");
            if (words.length > maxWords) {
                maxWords = words.length;
            }
        }
        return maxWords;
    }
}