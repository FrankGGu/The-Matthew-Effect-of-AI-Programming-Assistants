import java.util.Arrays;

class Solution {
    public long maximumTotalBeauty(int[] flowers, long newFlowers, int target, int full, int partial) {
        int n = flowers.length;
        Arrays.sort(flowers);

        long[] prefixSums = new long[n + 1];
        for (int i = 0; i < n; i++) {
            prefixSums[i + 1] = prefixSums[i] + flowers[i];
        }

        long maxBeauty = 0;
        long costForFull = 0;

        // Iterate through the number of gardens made full.
        // `numFull` represents the count of gardens made complete.
        // These will be the largest `numFull` gardens: `flowers[n - numFull]` to `flowers[n - 1]`.
        for (int numFull = 0; numFull <= n; numFull++) {
            // Calculate cost to make current `numFull` gardens complete.
            // If `numFull > 0`, we consider `flowers[n - numFull]` as the newest garden to make full.
            // Its cost is added to `costForFull`.
            if (numFull > 0) {
                if (flowers[n - numFull] < target) {
                    costForFull += (target - flowers[n - numFull]);
                }
            }

            // If we don't have enough newFlowers to make these `numFull` gardens complete,
            // we cannot make any more gardens full, so we break.
            if (costForFull > newFlowers) {
                break;
            }

            long currentBeauty = (long) numFull * full;
            long remainingFlowers = newFlowers - costForFull;

            // Now, consider the remaining `n - numFull` gardens: `flowers[0]` to `flowers[n - numFull - 1]`.
            // These will be the partially complete gardens.
            int numPartialGardens = n - numFull;

            if (numPartialGardens > 0) {
                // Find the maximum possible minimum flower count (`minFlowerCount`)
                // for these `numPartialGardens` using `remainingFlowers`.
                // `minFlowerCount` must be less than `target`.
                long low = 0, high = target - 1;
                long bestMinFlowerCount = 0;

                // Binary search for `minFlowerCount`.
                while (low <= high) {
                    long mid = low + (high - low) / 2;
                    if (mid < 0) mid = 0; // Ensure mid is non-negative

                    // `idx` is the count of gardens `flowers[0]` to `flowers[idx-1]`
                    // that are less than `mid` and need to be raised.
                    // `Arrays.binarySearch` returns `-(insertion point) - 1` if not found.
                    // `insertion point` is the index of the first element greater than the key.
                    int idx = Arrays.binarySearch(flowers, 0, numPartialGardens, (int) mid);
                    if (idx < 0) {
                        idx = -idx - 1;
                    }

                    // Cost to raise `flowers[0]` to `flowers[idx-1]` to `mid`.
                    // `mid * idx` is the target sum if all `idx` gardens reach `mid`.
                    // `prefixSums[idx]` is their current sum.
                    long costToRaisePartial = mid * idx - prefixSums[idx];

                    if (costToRaisePartial <= remainingFlowers) {
                        bestMinFlowerCount = mid;
                        low = mid + 1;
                    } else {
                        high = mid - 1;
                    }
                }
                currentBeauty += bestMinFlowerCount * numPartialGardens * partial;
            }
            maxBeauty = Math.max(maxBeauty, currentBeauty);
        }

        return maxBeauty;
    }
}