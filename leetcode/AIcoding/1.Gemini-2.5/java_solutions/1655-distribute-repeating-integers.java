import java.util.Arrays;
import java.util.HashMap;
import java.util.Map;

class Solution {
    private boolean canDistribute(int customerIndex, int[] counts, int[] quantities) {
        // Base case: All customers have been satisfied
        if (customerIndex == quantities.length) {
            return true;
        }

        int currentQuantity = quantities[customerIndex];

        // Iterate through all available item types (counts)
        for (int i = 0; i < counts.length; i++) {
            // If this item type has already been used by a previous customer (marked as 0)
            // or if it's too small to satisfy the current customer, skip it.
            if (counts[i] == 0 || counts[i] < currentQuantity) {
                continue;
            }

            // Temporarily use this item type for the current customer
            int temp = counts[i];
            counts[i] = 0; // Mark as used

            // Recursively try to satisfy the next customer
            if (canDistribute(customerIndex + 1, counts, quantities)) {
                return true; // If successful, propagate true
            }

            // Backtrack: restore the item type for other possibilities
            counts[i] = temp;
        }

        // If no item type could satisfy the current customer, return false
        return false;
    }

    public boolean canDistribute(int[] nums, int[] quantities) {
        // Step 1: Count frequencies of numbers in nums
        Map<Integer, Integer> freqMap = new HashMap<>();
        for (int num : nums) {
            freqMap.put(num, freqMap.getOrDefault(num, 0) + 1);
        }

        // Step 2: Convert frequencies to an array of available counts
        int[] counts = new int[freqMap.size()];
        int idx = 0;
        for (int count : freqMap.values()) {
            counts[idx++] = count;
        }

        // Step 3: Sort quantities in descending order. This is a common heuristic for backtracking.
        // It helps to prune the search space faster by trying to satisfy larger demands first.
        Arrays.sort(quantities);
        for (int j = 0; j < quantities.length / 2; j++) {
            int temp = quantities[j];
            quantities[j] = quantities[quantities.length - 1 - j];
            quantities[quantities.length - 1 - j] = temp;
        }

        // Step 4: Sort counts in descending order.
        // This can also help with pruning, by trying larger available item types first.
        Arrays.sort(counts);
        for (int j = 0; j < counts.length / 2; j++) {
            int temp = counts[j];
            counts[j] = counts[counts.length - 1 - j];
            counts[counts.length - 1 - j] = temp;
        }

        // Step 5: Start backtracking
        return canDistribute(0, counts, quantities);
    }
}