class Solution {
    public long zeroFilledSubarray(int[] nums) {
        long count = 0, currentZeroes = 0;
        for (int num : nums) {
            if (num == 0) {
                currentZeroes++;
                count += currentZeroes;
            } else {
                currentZeroes = 0;
            }
        }
        return count;
    }
}