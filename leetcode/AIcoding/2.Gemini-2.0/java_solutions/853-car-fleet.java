import java.util.Arrays;

class Solution {
    public int carFleet(int target, int[] position, int[] speed) {
        int n = position.length;
        double[][] cars = new double[n][2];
        for (int i = 0; i < n; i++) {
            cars[i][0] = position[i];
            cars[i][1] = (double) (target - position[i]) / speed[i];
        }
        Arrays.sort(cars, (a, b) -> Double.compare(a[0], b[0]));
        int fleets = 0;
        double currentMaxTime = 0;
        for (int i = n - 1; i >= 0; i--) {
            if (cars[i][1] > currentMaxTime) {
                fleets++;
                currentMaxTime = cars[i][1];
            }
        }
        return fleets;
    }
}