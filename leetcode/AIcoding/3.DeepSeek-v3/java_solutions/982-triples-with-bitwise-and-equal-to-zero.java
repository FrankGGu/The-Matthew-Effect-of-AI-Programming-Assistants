class Solution {
    public int countTriplets(int[] nums) {
        int count = 0;
        int n = nums.length;
        int[] freq = new int[1 << 16];

        for (int num : nums) {
            for (int mask = 0; mask < (1 << 16); mask++) {
                if ((num & mask) == 0) {
                    freq[mask]++;
                }
            }
        }

        for (int i = 0; i < n; i++) {
            for (int j = 0; j < n; j++) {
                int and = nums[i] & nums[j];
                count += freq[and];
            }
        }

        return count;
    }
}