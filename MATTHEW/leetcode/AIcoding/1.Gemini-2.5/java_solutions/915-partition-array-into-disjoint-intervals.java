class Solution {
    public int partitionDisjoint(int[] nums) {
        int n = nums.length;

        int max_left = nums[0];
        int max_overall = nums[0];
        int partition_length = 1;

        for (int i = 1; i < n; i++) {
            max_overall = Math.max(max_overall, nums[i]);

            if (nums[i] < max_left) {
                max_left = max_overall;
                partition_length = i + 1;
            }
        }

        return partition_length;
    }
}