class Solution {
    public int maximumEnemyForts(int[] forts) {
        int maxCaptured = 0;
        int start = -1; 

        for (int i = 0; i < forts.length; i++) {
            if (forts[i] != 0) {
                if (start != -1 && forts[start] != forts[i]) {
                    maxCaptured = Math.max(maxCaptured, i - start - 1);
                }
                start = i;
            }
        }
        return maxCaptured;
    }
}