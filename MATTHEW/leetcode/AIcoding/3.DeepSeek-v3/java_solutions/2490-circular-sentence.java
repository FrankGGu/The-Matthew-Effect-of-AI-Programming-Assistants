class Solution {
    public boolean isCircularSentence(String sentence) {
        String[] words = sentence.split(" ");
        int n = words.length;
        if (n == 1) {
            return words[0].charAt(0) == words[0].charAt(words[0].length() - 1);
        }
        for (int i = 0; i < n - 1; i++) {
            String current = words[i];
            String next = words[i + 1];
            if (current.charAt(current.length() - 1) != next.charAt(0)) {
                return false;
            }
        }
        return words[n - 1].charAt(words[n - 1].length() - 1) == words[0].charAt(0);
    }
}