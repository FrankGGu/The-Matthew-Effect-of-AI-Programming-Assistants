public class Solution {
    public int captureForts(int[] forts) {
        int maxCaptured = 0;
        int n = forts.length;

        for (int i = 0; i < n; i++) {
            if (forts[i] == 1) {
                int count = 0;
                for (int j = i + 1; j < n && forts[j] != -1; j++) {
                    count++;
                }
                maxCaptured = Math.max(maxCaptured, count);
            } else if (forts[i] == -1) {
                int count = 0;
                for (int j = i - 1; j >= 0 && forts[j] != 1; j--) {
                    count++;
                }
                maxCaptured = Math.max(maxCaptured, count);
            }
        }
        return maxCaptured;
    }
}