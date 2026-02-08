class Solution {
    public int minDeletions(int[] nums) {
        int n = nums.length;
        int deletions = 0;
        int count = 0;
        Arrays.sort(nums);

        for (int i = n - 1; i >= 0; i--) {
            if (count > 0 && nums[i] == nums[i + 1]) {
                deletions++;
            } else {
                count++;
            }
        }

        return deletions;
    }
}