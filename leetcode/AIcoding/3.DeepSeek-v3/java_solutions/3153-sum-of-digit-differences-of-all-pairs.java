class Solution {
    public long sumDigitDifferences(int[] nums) {
        long total = 0;
        int maxDigits = String.valueOf(nums[0]).length();
        for (int d = 0; d < maxDigits; d++) {
            int[] count = new int[10];
            for (int num : nums) {
                int digit = (num / (int) Math.pow(10, d)) % 10;
                count[digit]++;
            }
            for (int i = 0; i < 10; i++) {
                for (int j = i + 1; j < 10; j++) {
                    total += (long) count[i] * count[j];
                }
            }
        }
        return total;
    }
}