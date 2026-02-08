class Solution {
    public int longestSubsequence(String s, int k) {
        int n = s.length();
        int ans = 0;
        long currentVal = 0;
        long powerOf2 = 1;

        // Iterate from right to left to build the number from LSB to MSB.
        // This ensures that '1's are considered at their least significant positions first,
        // minimizing their contribution to the total value for a given length.
        for (int i = n - 1; i >= 0; i--) {
            if (s.charAt(i) == '0') {
                // '0's do not increase the value, so they can always be included
                // to maximize length, as long as they don't cause an overflow in powerOf2
                // which is not an issue for k up to 10^9.
                ans++;
            } else { // s.charAt(i) == '1'
                // If adding this '1' (at its current bit position) keeps the total value
                // less than or equal to k, then include it.
                // We also need to ensure powerOf2 itself doesn't exceed k to avoid unnecessary additions
                // and potential overflow if k was extremely large, though for k=10^9, long is sufficient.
                if (currentVal + powerOf2 <= k) {
                    currentVal += powerOf2;
                    ans++;
                } else {
                    // If we cannot add this '1', we cannot add any '1's from more significant
                    // positions either, because their powerOf2 contribution would be even larger.
                    // So, we can stop considering '1's.
                    // '0's from more significant positions can still be added, but the loop structure
                    // ensures all '0's are effectively counted first for the longest length.
                    // The current loop structure correctly handles this: it will continue to count '0's
                    // but will break if it encounters another '1' that cannot be added.
                    // However, for the purpose of maximizing length, if we can't add this '1',
                    // we can't add any *further* '1's.
                    // The loop will continue to process '0's which are always added to 'ans'.
                    // If we break here, we might miss '0's at higher positions.
                    // The current logic is fine: '0's are always added, '1's are added conditionally.
                    // If a '1' cannot be added, no future '1's can be added either because powerOf2 only increases.
                    // So, the `break` is appropriate here for '1's.
                    break;
                }
            }

            // Prepare powerOf2 for the next bit position (more significant).
            // Check if powerOf2 is already too large to prevent overflow before multiplication,
            // though for k <= 10^9, powerOf2 will not overflow 'long' before it exceeds 'k'.
            if (powerOf2 > k) { // Optimization: if powerOf2 is already greater than k,
                                // any subsequent '1' will definitely make currentVal + powerOf2 > k.
                                // This means no more '1's will be added, but '0's still count.
                                // The `break` inside the else block (for '1's) already handles this.
                                // No explicit break here is strictly needed, as the condition currentVal + powerOf2 <= k
                                // would fail for any '1' if powerOf2 is already > k.
            }
            powerOf2 *= 2;
        }

        return ans;
    }
}