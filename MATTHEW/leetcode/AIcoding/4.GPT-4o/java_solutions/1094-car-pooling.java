import java.util.Arrays;

public class Solution {
    public boolean carPooling(int[][] trips, int capacity) {
        int[] timeline = new int[1001];
        for (int[] trip : trips) {
            int passengers = trip[0];
            int start = trip[1];
            int end = trip[2];
            timeline[start] += passengers;
            timeline[end] -= passengers;
        }
        int currentPassengers = 0;
        for (int i = 0; i < timeline.length; i++) {
            currentPassengers += timeline[i];
            if (currentPassengers > capacity) {
                return false;
            }
        }
        return true;
    }
}