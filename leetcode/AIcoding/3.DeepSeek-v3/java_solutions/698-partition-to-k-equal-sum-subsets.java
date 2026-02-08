class Solution {
    public boolean canPartitionKSubsets(int[] nums, int k) {
        int sum = 0;
        for (int num : nums) sum += num;
        if (sum % k != 0) return false;
        int target = sum / k;
        Arrays.sort(nums);
        int idx = nums.length - 1;
        if (nums[idx] > target) return false;
        while (idx >= 0 && nums[idx] == target) {
            idx--;
            k--;
        }
        return partition(new int[k], nums, idx, target);
    }

    private boolean partition(int[] subsets, int[] nums, int idx, int target) {
        if (idx < 0) return true;
        int selected = nums[idx];
        for (int i = 0; i < subsets.length; i++) {
            if (subsets[i] + selected <= target) {
                subsets[i] += selected;
                if (partition(subsets, nums, idx - 1, target)) return true;
                subsets[i] -= selected;
            }
        }
        return false;
    }
}