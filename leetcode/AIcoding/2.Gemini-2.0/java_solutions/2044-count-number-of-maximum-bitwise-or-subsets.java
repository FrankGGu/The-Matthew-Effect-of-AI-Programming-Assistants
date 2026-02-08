class Solution {
    int count = 0;
    int maxOr = 0;

    public int countMaxOrSubsets(int[] nums) {
        maxOr = 0;
        for (int num : nums) {
            maxOr |= num;
        }
        count = 0;
        solve(nums, 0, 0);
        return count;
    }

    private void solve(int[] nums, int index, int currentOr) {
        if (index == nums.length) {
            if (currentOr == maxOr) {
                count++;
            }
            return;
        }

        solve(nums, index + 1, currentOr | nums[index]);
        solve(nums, index + 1, currentOr);
    }
}