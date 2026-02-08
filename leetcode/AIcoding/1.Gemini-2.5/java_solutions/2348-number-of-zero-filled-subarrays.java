class Solution {
    public long zeroFilledSubarray(int[] nums) {
        long totalZeroSubarrays = 0;
        long currentConsecutiveZeros = 0;

        for (int num : nums) {
            if (num == 0) {
                currentConsecutiveZeros++;
            } else {
                totalZeroSubarrays += (currentConsecutiveZeros * (currentConsecutiveZeros + 1)) / 2;
                currentConsecutiveZeros = 0;
            }
        }

        totalZeroSubarrays += (currentConsecutiveZeros * (currentConsecutiveZeros + 1)) / 2;

        return totalZeroSubarrays;
    }
}