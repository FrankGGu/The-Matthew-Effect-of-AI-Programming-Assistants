import java.util.*;

class Solution {
    public int earliestSecondToMarkIndices(int[] nums, int[][] changeIndices) {
        int n = nums.length;

        // Calculate the maximum possible sum of nums[i] to determine the upper bound for binary search.
        // This sum can be up to 10^5 * 10^9 = 10^14, so use long.
        long sumNums = 0;
        for (int x : nums) {
            sumNums += x;
        }

        // Binary search range for the earliest second 'k'.
        // Minimum possible k: n (if all nums[i] are 0, we need n seconds to mark them).
        // Maximum possible k: sum(nums[i]) + n (if we need to decrease all nums[i] and mark all n indices).
        long low = n;
        long high = sumNums + n;
        long ans = -1;

        while (low <= high) {
            long mid = low + (high - low) / 2;
            if (check(mid, nums, changeIndices, n)) {
                ans = mid;
                high = mid - 1;
            } else {
                low = mid + 1;
            }
        }
        return (int) ans;
    }

    // `check(k)` function: determines if it's possible to mark all `n` indices by second `k`.
    private boolean check(long k, int[] nums, int[][] changeIndices, int n) {
        // Step 1: For each index `i`, find the latest time `t <= k` where it appears in `changeIndices`.
        // `lastOccurrence[i]` stores this time (0-indexed index). Initialize with -1.
        int[] lastOccurrence = new int[n];
        Arrays.fill(lastOccurrence, -1);

        // Iterate through `changeIndices` to populate `lastOccurrence`.
        for (int i = 0; i < n; i++) {
            int idx = changeIndices[i][0] - 1; // Convert to 0-indexed
            int time = changeIndices[i][1];
            if (time <= k) {
                lastOccurrence[idx] = Math.max(lastOccurrence[idx], time);
            }
        }

        // Step 2: Create a list of "events". An event is `[time, nums_value]` for an index `i`
        // where `lastOccurrence[i]` is a valid time `t`. These are the indices we must mark
        // at or before their `lastOccurrence[i]` time.
        List<int[]> events = new ArrayList<>(); // Each element: [time, nums_value]
        for (int i = 0; i < n; i++) {
            if (lastOccurrence[i] != -1) {
                events.add(new int[]{lastOccurrence[i], nums[i]});
            }
        }
        // Sort events by their time.
        Collections.sort(events, (a, b) -> a[0] - b[0]);

        // Step 3: Use a max-heap to greedily determine which indices to mark.
        // The heap stores `nums_value` of indices we are currently planning to mark.
        // If we exceed available operations, we drop the largest `nums_value` (most expensive).
        PriorityQueue<Long> pq = new PriorityQueue<>(Collections.reverseOrder());
        long operationsUsedForSpecialMarks = 0; // Sum of (nums[i] + 1) for indices currently in pq.

        // Iterate through the sorted events.
        for (int[] event : events) {
            long eventTime = event[0];
            long numValue = event[1];

            // Add the current index's `nums_value` to the priority queue.
            // We provisionally plan to mark this index.
            pq.offer(numValue);
            // Update total operations needed for indices in pq: `nums_value` for decrease + 1 for mark.
            operationsUsedForSpecialMarks += (numValue + 1L);

            // If the total operations needed for indices in `pq` exceed the time available up to `eventTime`,
            // we must drop the most expensive index from our plan (the one with largest `nums_value`).
            while (operationsUsedForSpecialMarks > eventTime) {
                if (pq.isEmpty()) { 
                    // This case indicates an internal inconsistency if operationsUsedForSpecialMarks > 0,
                    // but it should not be reached if the logic is sound and k is valid.
                    return false; 
                }
                long removedVal = pq.poll();
                operationsUsedForSpecialMarks -= (removedVal + 1L);
            }
        }

        // Step 4: After processing all events, check if all `n` indices can be marked.
        // `pq.size()` is the number of indices we successfully planned to mark via `changeIndices` events.
        int numSpecialMarked = pq.size();

        // If not all `n` indices are covered by `changeIndices` events (i.e., `numSpecialMarked < n`),
        // the remaining `(n - numSpecialMarked)` indices must be marked using operation 1.
        // This is only possible if `nums[i]` is 0 for those remaining indices.
        if (numSpecialMarked < n) {
            int numZeroFreeMarkIndices = 0;
            for (int i = 0; i < n; i++) {
                // An index `i` can be freely marked if it has `nums[i] == 0`
                // AND it was NOT considered for a mandatory mark (i.e., `lastOccurrence[i] == -1`).
                if (lastOccurrence[i] == -1 && nums[i] == 0) {
                    numZeroFreeMarkIndices++;
                }
            }
            // If we don't have enough zero-valued indices to cover the remaining `n - numSpecialMarked` slots,
            // then it's impossible to mark all `n` indices.
            if (numZeroFreeMarkIndices < n - numSpecialMarked) {
                return false;
            }
        }

        // Step 5: Calculate the total operations needed and compare with `k`.
        // Total operations needed:
        // `operationsUsedForSpecialMarks` for the indices marked via `changeIndices` events.
        // `(n - numSpecialMarked)` for the remaining zero-valued indices (each takes 1 mark operation).
        long finalOpsNeeded = operationsUsedForSpecialMarks + (long)(n - numSpecialMarked);

        // Return true if the total operations needed are within the allowed time `k`.
        return finalOpsNeeded <= k;
    }
}