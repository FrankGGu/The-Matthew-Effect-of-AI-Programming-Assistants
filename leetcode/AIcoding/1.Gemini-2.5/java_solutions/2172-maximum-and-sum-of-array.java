import java.util.Arrays;

class Solution {
    public int maximumANDSum(int[] nums, int numSlots) {
        int n = nums.length;
        // Each slot can hold up to 2 numbers. We use 2 bits to represent the state of each slot:
        // 00 (0): empty
        // 01 (1): one number
        // 10 (2): two numbers (full)
        // So, for `numSlots` slots, we need `2 * numSlots` bits for the mask.
        int maxMask = 1 << (2 * numSlots); 

        // dp[mask] stores the maximum AND sum achievable when the slots are in the state represented by 'mask'.
        // Initialize dp with -1 to indicate unreachable states.
        int[] dp = new int[maxMask];
        Arrays.fill(dp, -1);

        // Base case: When no numbers have been placed, the mask is 0 (all slots empty), and the sum is 0.
        dp[0] = 0;

        // Iterate through each number in the 'nums' array.
        // For each number, we consider placing it into an available slot.
        for (int num : nums) {
            // Create a new dp array for the current iteration to store results after placing 'num'.
            // This prevents using results from the current 'num' placement when considering other placements for 'num'.
            int[] next_dp = new int[maxMask];
            Arrays.fill(next_dp, -1);

            // Iterate through all possible previous masks (states of slots before placing 'num').
            for (int currentMask = 0; currentMask < maxMask; currentMask++) {
                // If the currentMask state was not reachable (no valid way to get this state), skip it.
                if (dp[currentMask] == -1) {
                    continue;
                }

                // Try to place the current number 'num' into each of the 'numSlots' slots.
                for (int slotIdx = 0; slotIdx < numSlots; slotIdx++) {
                    // Extract the current state of the slot at 'slotIdx'.
                    // The state is represented by 2 bits starting at position '2 * slotIdx'.
                    // We use '& 3' (0b11) to get these two bits.
                    int slotState = (currentMask >> (2 * slotIdx)) & 3;

                    // If the slot has capacity (i.e., it contains less than 2 numbers).
                    if (slotState < 2) {
                        // Calculate the new state for this slot (one more number placed).
                        int nextSlotState = slotState + 1;

                        // Calculate the new mask by updating the bits for this slot.
                        // 1. Clear the current two bits for slot 'slotIdx' in 'currentMask'.
                        //    ~(3 << (2 * slotIdx)) creates a mask with 0s at the slot's bit positions and 1s elsewhere.
                        int nextMask = currentMask & ~(3 << (2 * slotIdx));
                        // 2. Set the new two bits for slot 'slotIdx' to 'nextSlotState'.
                        nextMask |= (nextSlotState << (2 * slotIdx));

                        // Calculate the AND sum for placing 'num' into this slot.
                        // Slot values are 1-indexed (slot 0 corresponds to value 1, slot 1 to value 2, etc.).
                        int currentAndSum = num & (slotIdx + 1);

                        // Update the next_dp array: take the maximum sum for this 'nextMask' state.
                        // It's either the previously recorded sum for 'nextMask' or the sum achieved
                        // by placing 'num' from 'currentMask' state.
                        next_dp[nextMask] = Math.max(next_dp[nextMask], dp[currentMask] + currentAndSum);
                    }
                }
            }
            // After iterating through all possible placements for the current 'num',
            // update the 'dp' array to 'next_dp' for the next iteration (next number).
            dp = next_dp;
        }

        // After all numbers have been placed, the maximum AND sum will be the maximum value
        // found in the final 'dp' array.
        int maxAndSum = 0;
        for (int val : dp) {
            maxAndSum = Math.max(maxAndSum, val);
        }

        return maxAndSum;
    }
}