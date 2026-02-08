class Solution {
    public int maximumEnergyBoost(int[] energyBoosts) {
        if (energyBoosts == null || energyBoosts.length < 2) {
            // According to LeetCode problem constraints, this case might not occur
            // or a specific return value (e.g., 0 or -1) would be specified.
            // Returning 0 as a default for no valid pair.
            return 0; 
        }

        int max1 = Integer.MIN_VALUE; // Stores the largest energy boost found
        int max2 = Integer.MIN_VALUE; // Stores the second largest energy boost found

        for (int boost : energyBoosts) {
            if (boost > max1) {
                // If current boost is greater than the largest found so far,
                // the old largest becomes the new second largest,
                // and the current boost becomes the new largest.
                max2 = max1;
                max1 = boost;
            } else if (boost > max2) {
                // If current boost is not greater than the largest (max1),
                // but is greater than the second largest (max2),
                // then it becomes the new second largest.
                // This handles cases where boost is equal to max1 (e.g., [5, 5, 1])
                // and also cases where boost is between max1 and max2.
                max2 = boost;
            }
        }

        return max1 + max2;
    }
}