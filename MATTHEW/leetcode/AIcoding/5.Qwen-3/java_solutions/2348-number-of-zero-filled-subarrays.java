public class Solution {
    public long zeroFilledSubarrays(int[] nums) {
        long count = 0;
        int consecutiveZeros = 0;

        for (int num : nums) {
            if (num == 0) {
                consecutiveZeros++;
                count += consecutiveZeros;
            } else {
                consecutiveZeros = 0;
            }
        }

        return count;
    }
}