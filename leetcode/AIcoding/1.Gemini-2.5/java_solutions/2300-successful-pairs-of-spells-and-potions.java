import java.util.Arrays;

class Solution {
    public int[] successfulPairs(int[] spells, int[] potions, long success) {
        Arrays.sort(potions); // Sort the potions array to enable binary search
        int n = spells.length;
        int m = potions.length;
        int[] result = new int[n];

        for (int i = 0; i < n; i++) {
            long spell = spells[i];

            // Calculate the minimum required potion value for the current spell
            // to achieve a successful pair.
            // This is equivalent to ceil(success / spell).
            // Using integer arithmetic: (success + spell - 1) / spell
            // Note: spell is positive, so no division by zero.
            long minPotionRequired = (success + spell - 1) / spell;

            // Perform binary search to find the index of the first potion
            // that is greater than or equal to `minPotionRequired`.
            int low = 0;
            int high = m - 1;
            int firstSuccessfulPotionIndex = m; // Default to 'm' if no such potion is found

            while (low <= high) {
                int mid = low + (high - low) / 2;
                // Compare potion value (int) with minPotionRequired (long).
                // potions[mid] will be implicitly promoted to long for comparison.
                if (potions[mid] >= minPotionRequired) {
                    firstSuccessfulPotionIndex = mid; // This potion is successful, try to find an earlier one
                    high = mid - 1; 
                } else {
                    low = mid + 1; // This potion is too small, look in the right half
                }
            }

            // The number of successful pairs for the current spell is the count
            // of potions from 'firstSuccessfulPotionIndex' to the end of the array.
            result[i] = m - firstSuccessfulPotionIndex;
        }

        return result;
    }
}