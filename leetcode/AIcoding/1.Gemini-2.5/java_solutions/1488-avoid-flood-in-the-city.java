import java.util.HashMap;
import java.util.Map;
import java.util.TreeSet;

class Solution {
    public int[] avoidFlood(int[] rains) {
        int n = rains.length;
        int[] ans = new int[n];

        // Map to store the last day a lake rained
        // lakeId -> dayIndex
        Map<Integer, Integer> lakeToLastRainDay = new HashMap<>();

        // TreeSet to store indices of available dry days
        // Sorted set helps find the earliest dry day efficiently
        TreeSet<Integer> dryDaysAvailable = new TreeSet<>();

        for (int i = 0; i < n; i++) {
            int lakeId = rains[i];

            if (lakeId > 0) { // It's a rainy day for a specific lake
                ans[i] = -1; // Mark as a rain day, no drying happens

                if (lakeToLastRainDay.containsKey(lakeId)) {
                    // This lake rained before and is currently full.
                    // We need to find a dry day between its last rain and today.
                    int lastRainDay = lakeToLastRainDay.get(lakeId);

                    // Find the earliest dry day that occurred AFTER the last rain for this lake
                    // and BEFORE the current rain for this lake.
                    Integer dryDayIndex = dryDaysAvailable.ceiling(lastRainDay);

                    if (dryDayIndex == null || dryDayIndex > i) {
                        // No suitable dry day found, or the earliest dry day is after current rain.
                        // This means a flood cannot be avoided.
                        return new int[0];
                    }

                    // Use this dry day to dry the current lake
                    ans[dryDayIndex] = lakeId;
                    dryDaysAvailable.remove(dryDayIndex);
                }
                // Update the last rain day for this lake to the current day
                lakeToLastRainDay.put(lakeId, i);

            } else { // rains[i] == 0, it's a dry day
                // Add the current day's index to the set of available dry days
                dryDaysAvailable.add(i);
                // Temporarily set ans[i] to 1. This will be overwritten if this dry day
                // is later used to dry a specific lake. If not used, 1 is a valid default choice.
                ans[i] = 1; 
            }
        }

        return ans;
    }
}