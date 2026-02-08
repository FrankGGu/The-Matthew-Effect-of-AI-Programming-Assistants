class Solution {
    private long gcd(long a, long b) {
        while (b != 0) {
            long temp = b;
            b = a % b;
            a = temp;
        }
        return a;
    }

    // Calculates LCM(a, b) with overflow check.
    // If LCM overflows Long.MAX_VALUE, returns Long.MAX_VALUE as a sentinel.
    private long lcm(long a, long b) {
        if (a == 0 || b == 0) return 0; // Denominations are positive, so this case shouldn't be hit with actual denominations.
        if (a == 1) return b;
        if (b == 1) return a;

        // If 'a' or 'b' is already the sentinel for overflow, then the LCM will also be overflowed.
        if (a == Long.MAX_VALUE || b == Long.MAX_VALUE) {
            return Long.MAX_VALUE;
        }

        long commonDivisor = gcd(a, b);
        // Check for overflow before multiplication: (a / commonDivisor) * b
        // If (a / commonDivisor) > Long.MAX_VALUE / b, then overflow will occur.
        // Note: Long.MAX_VALUE / b is safe because b is positive.
        if (a / commonDivisor > Long.MAX_VALUE / b) {
            return Long.MAX_VALUE; // Indicate overflow
        }
        return (a / commonDivisor) * b;
    }

    // Counts the number of distinct amounts <= 'amount' that can be formed
    // using the given denominations. Uses inclusion-exclusion principle.
    private long countAmounts(long amount, int[] denominations) {
        long totalCount = 0;
        int n = denominations.length;

        // Iterate through all non-empty subsets of denominations
        for (int i = 1; i < (1 << n); i++) {
            long currentLcm = 1;
            int setBits = 0; // To count elements in the current subset

            for (int j = 0; j < n; j++) {
                if (((i >> j) & 1) == 1) { // If j-th denomination is in the current subset
                    setBits++;
                    // If currentLcm already overflowed, it means the true LCM is too large.
                    // Further multiplication will also result in an overflowed LCM.
                    if (currentLcm == Long.MAX_VALUE) {
                        break; 
                    }
                    currentLcm = lcm(currentLcm, (long)denominations[j]);
                }
            }

            // If currentLcm is 0 (should not happen with positive denominations) or
            // if it's the sentinel Long.MAX_VALUE (meaning true LCM > Long.MAX_VALUE),
            // then there are effectively no multiples within 'amount' for this subset.
            // So, amount / currentLcm would be 0.
            if (currentLcm == 0 || currentLcm == Long.MAX_VALUE) {
                continue;
            }

            long multiples = amount / currentLcm;

            if (setBits % 2 == 1) { // Odd number of elements in subset, add to total
                totalCount += multiples;
            } else { // Even number of elements in subset, subtract from total
                totalCount -= multiples;
            }
        }
        return totalCount;
    }

    public long kthSmallestAmount(int[] denominations, int k) {
        long low = 1;
        // The maximum possible answer is bounded by Long.MAX_VALUE, as per problem constraints.
        // A safe upper bound for binary search.
        long high = Long.MAX_VALUE; 
        long ans = Long.MAX_VALUE;

        while (low <= high) {
            long mid = low + (high - low) / 2;

            // Ensure mid is at least 1, though low starts at 1 so mid will always be >= 1.
            if (mid == 0) { 
                low = 1;
                continue;
            }

            long count = countAmounts(mid, denominations);

            if (count >= k) {
                ans = mid;
                high = mid - 1;
            } else {
                low = mid + 1;
            }
        }
        return ans;
    }
}