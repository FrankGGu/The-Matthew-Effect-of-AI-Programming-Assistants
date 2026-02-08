import java.util.Arrays;

class Solution {
    public int eliminateMaximum(int[] dist, int[] speed) {
        int n = dist.length;
        double[] arrivalTimes = new double[n];

        for (int i = 0; i < n; i++) {
            arrivalTimes[i] = (double) dist[i] / speed[i];
        }

        Arrays.sort(arrivalTimes);

        int eliminatedCount = 0;
        for (int i = 0; i < n; i++) {
            // We shoot the i-th monster (0-indexed) at time 'i'.
            // For example, the first monster is shot at time 0, the second at time 1, and so on.
            // A monster can be eliminated if its arrival time is greater than or equal to the time we shoot it.
            // If arrivalTimes[i] < i, it means the monster arrived before we could shoot it.
            if (arrivalTimes[i] <= i) {
                break;
            }
            eliminatedCount++;
        }

        return eliminatedCount;
    }
}