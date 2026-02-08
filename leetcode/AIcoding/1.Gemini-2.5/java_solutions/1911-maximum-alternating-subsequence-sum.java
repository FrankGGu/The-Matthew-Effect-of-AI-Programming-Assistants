class Solution {
    public long maxAlternatingSum(int[] nums) {
        long dpEven = 0; // Maximum alternating sum ending with an element at an even index (positive contribution)
        long dpOdd = 0;  // Maximum alternating sum ending with an element at an odd index (negative contribution)

        for (int num : nums) {
            // Option 1: Include num as a positive term (even index in subsequence)
            // It can either extend a subsequence that ended with a negative term (dpOdd + num)
            // or start a new subsequence (num itself, which is covered by dpOdd being 0 initially)
            // We also consider not taking num, keeping the current dpEven.
            long newDpEven = Math.max(dpEven, dpOdd + num);

            // Option 2: Include num as a negative term (odd index in subsequence)
            // It must extend a subsequence that ended with a positive term (dpEven - num)
            // We also consider not taking num, keeping the current dpOdd.
            long newDpOdd = Math.max(dpOdd, dpEven - num);

            dpEven = newDpEven;
            dpOdd = newDpOdd;
        }

        // The maximum alternating sum will always end with a positive term (even index)
        // because if it ended with a negative term, removing that term would yield a greater or equal sum.
        return dpEven;
    }
}