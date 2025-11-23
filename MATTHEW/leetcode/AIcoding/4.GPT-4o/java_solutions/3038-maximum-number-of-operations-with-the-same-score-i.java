class Solution {
    public int maximumOperations(int[] nums, int target) {
        int count = 0;
        int sum = 0;
        for (int num : nums) {
            sum += num;
        }
        if (sum < target) return -1;

        Arrays.sort(nums);
        for (int i = nums.length - 1; i >= 0; i--) {
            if (sum >= target) {
                sum -= nums[i];
                count++;
            }
        }
        return count;
    }
}