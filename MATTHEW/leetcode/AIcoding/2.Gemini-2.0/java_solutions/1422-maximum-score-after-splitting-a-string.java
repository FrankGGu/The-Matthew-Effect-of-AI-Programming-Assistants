class Solution {
    public int maxScore(String s) {
        int n = s.length();
        int maxScore = 0;
        for (int i = 1; i < n; i++) {
            String left = s.substring(0, i);
            String right = s.substring(i);
            int leftZeros = 0;
            for (char c : left.toCharArray()) {
                if (c == '0') {
                    leftZeros++;
                }
            }
            int rightOnes = 0;
            for (char c : right.toCharArray()) {
                if (c == '1') {
                    rightOnes++;
                }
            }
            maxScore = Math.max(maxScore, leftZeros + rightOnes);
        }
        return maxScore;
    }
}