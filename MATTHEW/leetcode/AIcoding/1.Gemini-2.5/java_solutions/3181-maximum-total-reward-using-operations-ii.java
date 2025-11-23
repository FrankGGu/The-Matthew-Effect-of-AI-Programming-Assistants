import java.util.Arrays;
import java.util.BitSet;

class Solution {
    public int maxTotalReward(int[] rewardValues) {
        Arrays.sort(rewardValues);

        // The maximum possible sum S for a sequence r_1, r_2, ..., r_k
        // where r_i > sum(r_1, ..., r_{i-1}) and r_k is the largest chosen reward.
        // S = sum(r_1, ..., r_k) = sum(r_1, ..., r_{k-1}) + r_k.
        // Since sum(r_1, ..., r_{k-1}) < r_k, it implies S < r_k + r_k = 2 * r_k.
        // The maximum possible value for r_k is 2000 (from problem constraints).
        // Therefore, the maximum possible sum S is strictly less than 2 * 2000 = 4000.
        // A BitSet of size 4000 (indices 0 to 3999) is sufficient to store all possible sums.
        int maxPossibleSumExclusive = 4000; 
        BitSet dp = new BitSet(maxPossibleSumExclusive);

        // Initialize dp: A sum of 0 is achievable (by choosing no rewards).
        dp.set(0);

        // Iterate through each reward value in sorted order.
        for (int r : rewardValues) {
            // We want to update dp by considering adding 'r' to existing achievable sums 's'.
            // The condition for adding 'r' is that 's' must be strictly less than 'r'.

            // Create a temporary BitSet from dp.
            BitSet temp = (BitSet) dp.clone();

            // Clear all bits in 'temp' from index 'r' up to maxPossibleSumExclusive - 1.
            // This effectively filters 'temp' to contain only sums 's' where 's < r'.
            temp.clear(r, maxPossibleSumExclusive);

            // Shift the filtered sums by 'r' positions to the left.
            // If bit 's' was set in 'temp', now bit 's + r' will be set.
            temp.shiftLeft(r);

            // Union 'temp' with the original 'dp'.
            // This adds all newly formed sums (s + r) to our set of achievable sums.
            dp.or(temp);
        }

        // After processing all reward values, the maximum total reward is the largest index 'i'
        // for which dp.get(i) is true. We search backwards from the maximum possible index.
        return dp.previousSetBit(maxPossibleSumExclusive - 1);
    }
}