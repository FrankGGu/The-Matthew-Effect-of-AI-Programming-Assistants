import java.util.*;

class Solution {
    public int carFleet(int target, int[] position, int[] speed) {
        int n = position.length;
        double[] time = new double[n];
        for (int i = 0; i < n; i++) {
            time[i] = (double)(target - position[i]) / speed[i];
        }
        Arrays.sort(position);
        Arrays.sort(time);
        int fleets = 0;
        double lastTime = 0;
        for (int i = n - 1; i >= 0; i--) {
            if (time[i] > lastTime) {
                fleets++;
                lastTime = time[i];
            }
        }
        return fleets;
    }
}