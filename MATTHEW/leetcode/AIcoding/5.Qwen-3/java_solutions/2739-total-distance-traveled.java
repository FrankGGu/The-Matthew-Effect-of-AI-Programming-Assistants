public class Solution {
    public int totalDistanceTraveled(int[] capacity, int[] trips) {
        int total = 0;
        int current = 0;
        for (int i = 0; i < trips.length; i++) {
            if (trips[i] > 0) {
                total += Math.abs(current);
                current += trips[i];
            } else {
                total += Math.abs(current);
                current -= Math.abs(trips[i]);
            }
        }
        return total;
    }
}