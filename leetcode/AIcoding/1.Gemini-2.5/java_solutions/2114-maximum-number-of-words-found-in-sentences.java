class Solution {
    public int mostWordsFound(String[] sentences) {
        int maxWords = 0;
        for (String sentence : sentences) {
            int currentWords = sentence.split(" ").length;
            if (currentWords > maxWords) {
                maxWords = currentWords;
            }
        }
        return maxWords;
    }
}