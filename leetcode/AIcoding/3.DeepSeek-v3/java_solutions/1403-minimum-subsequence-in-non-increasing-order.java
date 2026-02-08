class Solution {
    public List<Integer> minSubsequence(int[] nums) {
        Arrays.sort(nums);
        int totalSum = 0;
        for (int num : nums) {
            totalSum += num;
        }
        List<Integer> result = new ArrayList<>();
        int currentSum = 0;
        for (int i = nums.length - 1; i >= 0; i--) {
            currentSum += nums[i];
            result.add(nums[i]);
            if (currentSum > totalSum - currentSum) {
                break;
            }
        }
        return result;
    }
}