class Solution {
    public String smallestGoodBase(String n) {
        long nVal = Long.parseLong(n);

        // Iterate through possible lengths of the "all ones" representation.
        // If n = 11...1 (len times) in base k, then n >= k^(len-1).
        // Since the smallest possible base k is 2, n >= 2^(len-1).
        // This implies len-1 <= log2(n), so len <= log2(n) + 1.
        // For n up to 10^18, log2(10^18) is approximately 59.79.
        // So, the maximum possible length (number of '1's) is around 60.
        // We iterate 'len' downwards because a larger 'len' implies a smaller base 'k'.
        // The first 'k' we find will be the smallest good base.
        for (int len = 60; len >= 2; len--) {
            // Binary search for the base 'k'.
            // Lower bound for k is 2.
            // Upper bound for k: From n > k^(len-1), we get k < n^(1/(len-1)).
            // We add a small buffer (+2) to the upper bound to account for floating-point precision issues.
            long low = 2;
            long high = (long) (Math.pow(nVal, 1.0 / (len - 1)) + 2);

            // If the calculated high bound is less than the low bound, it means no k is possible for this len.
            // This check is mainly for very small n and large len, where Math.pow might result in a value less than 2.
            if (high < low) {
                continue;
            }

            while (low <= high) {
                long mid = low + (high - low) / 2;

                // Ensure mid is at least 2, as base k must be >= 2.
                if (mid < 2) {
                    low = 2;
                    continue;
                }

                long sum = 1; // Represents 1 * k^0
                long currentPower = 1; // Represents k^0
                boolean overflow = false;

                // Calculate sum = 1 + mid + mid^2 + ... + mid^(len-1)
                for (int i = 1; i < len; i++) {
                    // Check for overflow before multiplication: currentPower * mid
                    // If currentPower > Long.MAX_VALUE / mid, then currentPower * mid would overflow.
                    if (Long.MAX_VALUE / mid < currentPower) {
                        overflow = true;
                        break;
                    }
                    currentPower *= mid;

                    // Check for overflow before addition: sum + currentPower
                    // If sum > Long.MAX_VALUE - currentPower, then sum + currentPower would overflow.
                    if (Long.MAX_VALUE - currentPower < sum) {
                        overflow = true;
                        break;
                    }
                    sum += currentPower;
                }

                if (overflow || sum < 0) { // sum < 0 also indicates overflow (wrapped around to negative)
                    high = mid - 1; // 'mid' (k) is too large, try a smaller base
                } else if (sum == nVal) {
                    // Found a valid base 'mid' for the current 'len'.
                    // Since we iterate 'len' downwards, this 'mid' is the smallest good base.
                    return String.valueOf(mid);
                } else if (sum < nVal) {
                    low = mid + 1; // 'mid' (k) is too small, try a larger base
                } else { // sum > nVal
                    high = mid - 1; // 'mid' (k) is too large, try a smaller base
                }
            }
        }

        // This line should theoretically not be reached.
        // For len=2, n = k+1, so k = n-1. The binary search will always find n-1
        // as a valid base for len=2 if no solution was found for larger 'len'.
        // Thus, a return statement will always be hit inside the loop.
        return String.valueOf(nVal - 1); 
    }
}