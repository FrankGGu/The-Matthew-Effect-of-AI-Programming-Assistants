class Solution {
    public int mostWords(String[] sentences) {
        int maxWords = 0;
        for (String sentence : sentences) {
            int wordCount = sentence.split(" ").length;
            maxWords = Math.max(maxWords, wordCount);
        }
        return maxWords;
    }
}