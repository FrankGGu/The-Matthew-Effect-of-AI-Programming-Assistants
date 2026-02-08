class Solution {
    public long zeroFilledSubarray(int[] nums) {
        long result = 0;
        long current = 0;
        for (int num : nums) {
            if (num == 0) {
                current++;
                result += current;
            } else {
                current = 0;
            }
        }
        return result;
    }
}