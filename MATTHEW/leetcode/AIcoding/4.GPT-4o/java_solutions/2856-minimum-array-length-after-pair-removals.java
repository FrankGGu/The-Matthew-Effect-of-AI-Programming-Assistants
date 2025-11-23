class Solution {
    public int minLengthAfterRemovals(int[] nums) {
        Arrays.sort(nums);
        int n = nums.length;
        int maxCount = 0;
        int count = 1;

        for (int i = 1; i < n; i++) {
            if (nums[i] == nums[i - 1]) {
                count++;
            } else {
                maxCount = Math.max(maxCount, count);
                count = 1;
            }
        }
        maxCount = Math.max(maxCount, count);

        return n - maxCount;
    }
}