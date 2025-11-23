import java.util.Arrays;

class Solution {
    public int findRadius(int[] houses, int[] heaters) {
        Arrays.sort(houses);
        Arrays.sort(heaters);

        int maxRadius = 0;
        int heaterPointer = 0;

        for (int house : houses) {
            // Advance heaterPointer until heaters[heaterPointer + 1] is to the right of the house
            // or we are at the last heater.
            // This ensures heaterPointer points to the heater that is just to the left of or at the house,
            // or the first heater if all heaters are to the right of the house.
            while (heaterPointer < heaters.length - 1 && heaters[heaterPointer + 1] <= house) {
                heaterPointer++;
            }

            // Calculate distance to the heater at heaterPointer
            int dist1 = Math.abs(house - heaters[heaterPointer]);
            int minDistForHouse = dist1;

            // If there's a heater to the right of the current heaterPointer,
            // check if it's closer to the house.
            if (heaterPointer < heaters.length - 1) {
                int dist2 = Math.abs(house - heaters[heaterPointer + 1]);
                minDistForHouse = Math.min(dist1, dist2);
            }

            // Update the maximum radius needed so far
            maxRadius = Math.max(maxRadius, minDistForHouse);
        }

        return maxRadius;
    }
}