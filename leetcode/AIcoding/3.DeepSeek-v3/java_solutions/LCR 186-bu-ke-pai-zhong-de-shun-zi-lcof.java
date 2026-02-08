class Solution {
    public boolean canBePlaced(int[] nums) {
        int n = nums.length;
        if (n == 0) return true;
        Arrays.sort(nums);
        int zeros = 0;
        for (int i = 0; i < n - 1; i++) {
            if (nums[i] == 0) {
                zeros++;
                continue;
            }
            int diff = nums[i + 1] - nums[i] - 1;
            if (diff < 0) return false;
            zeros -= diff;
            if (zeros < 0) return false;
        }
        return true;
    }
}