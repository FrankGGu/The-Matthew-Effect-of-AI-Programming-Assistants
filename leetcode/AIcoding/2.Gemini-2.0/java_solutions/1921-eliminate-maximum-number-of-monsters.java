import java.util.Arrays;

class Solution {
    public int eliminateMaximum(int[] dist, int[] speed) {
        int n = dist.length;
        double[] arrivalTimes = new double[n];
        for (int i = 0; i < n; i++) {
            arrivalTimes[i] = (double) dist[i] / speed[i];
        }
        Arrays.sort(arrivalTimes);
        int eliminated = 0;
        for (int i = 0; i < n; i++) {
            if (arrivalTimes[i] <= i) {
                break;
            }
            eliminated++;
        }
        return eliminated;
    }
}