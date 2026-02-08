class Solution {
    public int maxScore(String s) {
        int maxScore = 0;
        int onesCount = 0;
        int zerosCount = 0;

        for (char c : s.toCharArray()) {
            if (c == '1') {
                onesCount++;
            }
        }

        for (int i = 0; i < s.length() - 1; i++) {
            if (s.charAt(i) == '0') {
                zerosCount++;
            } else {
                onesCount--;
            }
            maxScore = Math.max(maxScore, zerosCount + onesCount);
        }

        return maxScore;
    }
}