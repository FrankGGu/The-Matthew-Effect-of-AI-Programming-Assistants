class Solution {
    public long minimumReplacement(int[] nums) {
        long operations = 0;
        int n = nums.length;
        int prev = nums[n - 1];

        for (int i = n - 2; i >= 0; i--) {
            if (nums[i] > prev) {
                int parts = (nums[i] + prev - 1) / prev;
                operations += parts - 1;
                prev = nums[i] / parts;
            } else {
                prev = nums[i];
            }
        }

        return operations;
    }
}