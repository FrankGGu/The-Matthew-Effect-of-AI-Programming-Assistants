import java.util.HashMap;
import java.util.Map;

class Solution {
    private int batchSize;
    private Map<Long, Integer> memo;

    public int maxHappyGroups(int batchSize, int[] groups) {
        this.batchSize = batchSize;
        int[] counts = new int[batchSize];
        for (int groupSize : groups) {
            counts[groupSize % batchSize]++;
        }

        int totalFreshGroups = counts[0]; // Groups with remainder 0 always get fresh donuts

        // Optimize by reducing counts: if we have 'batchSize' groups of remainder 'r',
        // we can form one fresh group and effectively reduce 'counts[r]' by 'batchSize'.
        // This is because (batchSize * r) % batchSize == 0.
        for (int r = 1; r < batchSize; r++) {
            totalFreshGroups += counts[r] / batchSize;
            counts[r] %= batchSize;
        }

        memo = new HashMap<>();
        // Start DFS from current_remainder_in_batch = 0, with remaining counts
        totalFreshGroups += dfs(0, counts);
        return totalFreshGroups;
    }

    // current_rem_in_batch: current remainder of donuts in the batch (0 to batchSize - 1)
    // counts: array of remaining groups for each remainder (counts[r] < batchSize for r > 0)
    private int dfs(int current_rem_in_batch, int[] counts) {
        // Encode the state (current_rem_in_batch and counts array) into a long key for memoization.
        // Each count[r] and current_rem_in_batch needs 4 bits (since max value is batchSize-1 = 8).
        // Max bits for counts: (batchSize - 1) * 4 = 8 * 4 = 32 bits.
        // Max bits for current_rem_in_batch: 4 bits.
        // Total bits needed: 36 bits, which fits in a long.
        long stateKey = current_rem_in_batch;
        for (int r = 1; r < batchSize; r++) {
            stateKey = (stateKey << 4) | counts[r];
        }

        if (memo.containsKey(stateKey)) {
            return memo.get(stateKey);
        }

        int maxFreshGroups = 0;
        boolean foundNextMove = false;

        // Try to pick each available group type
        for (int r = 1; r < batchSize; r++) {
            if (counts[r] > 0) {
                foundNextMove = true;
                counts[r]--; // Temporarily use one group of remainder 'r'

                int currentFresh = 0;
                int newRemInBatch = (current_rem_in_batch + r) % batchSize;
                if (newRemInBatch == 0) {
                    currentFresh = 1; // This group completed a fresh batch!
                }

                maxFreshGroups = Math.max(maxFreshGroups, currentFresh + dfs(newRemInBatch, counts));

                counts[r]++; // Backtrack: restore count for other branches
            }
        }

        if (!foundNextMove) { // No more groups left to pick
            return 0;
        }

        memo.put(stateKey, maxFreshGroups);
        return maxFreshGroups;
    }
}