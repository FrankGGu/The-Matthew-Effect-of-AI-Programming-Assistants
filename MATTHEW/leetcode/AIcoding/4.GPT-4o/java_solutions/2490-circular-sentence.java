class Solution {
    public boolean isCircularSentence(String sentence) {
        String[] words = sentence.split(" ");
        int n = words.length;
        for (int i = 0; i < n; i++) {
            if (words[i].charAt(0) != (i == 0 ? words[n - 1].charAt(words[n - 1].length() - 1) : words[i - 1].charAt(words[i - 1].length() - 1))) {
                return false;
            }
        }
        return true;
    }
}