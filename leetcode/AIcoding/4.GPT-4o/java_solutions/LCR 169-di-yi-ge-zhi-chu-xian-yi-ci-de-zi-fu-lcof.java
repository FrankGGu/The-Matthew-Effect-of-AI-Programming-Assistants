class Solution {
    public int maxScore(String s) {
        int n = s.length();
        int[] leftCount = new int[n + 1];
        int[] rightCount = new int[n + 1];

        for (int i = 0; i < n; i++) {
            leftCount[i + 1] = leftCount[i] + (s.charAt(i) == '0' ? 1 : 0);
        }

        for (int i = n - 1; i >= 0; i--) {
            rightCount[i] = rightCount[i + 1] + (s.charAt(i) == '1' ? 1 : 0);
        }

        int maxScore = 0;
        for (int i = 0; i < n; i++) {
            maxScore = Math.max(maxScore, leftCount[i + 1] + rightCount[i + 1]);
        }

        return maxScore;
    }
}