class Solution {
    public long countAlternatingSubarrays(int[] nums) {
        long total = 0;
        int current = 1;

        for (int i = 1; i < nums.length; i++) {
            if (nums[i] != nums[i - 1]) {
                current++;
            } else {
                total += (long) current * (current + 1) / 2;
                current = 1;
            }
        }
        total += (long) current * (current + 1) / 2;

        return total;
    }
}