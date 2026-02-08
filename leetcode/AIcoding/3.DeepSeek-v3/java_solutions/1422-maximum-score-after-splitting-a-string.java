class Solution {
    public int maxScore(String s) {
        int maxScore = 0;
        int zeros = 0;
        int ones = 0;

        for (char c : s.toCharArray()) {
            if (c == '1') {
                ones++;
            }
        }

        for (int i = 0; i < s.length() - 1; i++) {
            char c = s.charAt(i);
            if (c == '0') {
                zeros++;
            } else {
                ones--;
            }
            maxScore = Math.max(maxScore, zeros + ones);
        }

        return maxScore;
    }
}