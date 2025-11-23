class Solution {
    public int bestRotation(int[] A) {
        int n = A.length;
        int[] score = new int[n];
        for (int i = 0; i < n; i++) {
            score[(i - A[i] + 1 + n) % n]--;
            score[i]++;
        }
        int maxScore = 0, bestK = 0;
        for (int i = 0, currentScore = 0; i < n; i++) {
            currentScore += score[i];
            if (currentScore > maxScore) {
                maxScore = currentScore;
                bestK = i;
            }
        }
        return bestK;
    }
}