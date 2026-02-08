class Solution {
    public int totalHammingDistance(int[] nums) {
        int total = 0;
        int n = nums.length;
        for (int i = 0; i < 32; i++) {
            int count = 0;
            for (int j = 0; j < n; j++) {
                if ((nums[j] & (1 << i)) != 0) {
                    count++;
                }
            }
            total += count * (n - count);
        }
        return total;
    }
}