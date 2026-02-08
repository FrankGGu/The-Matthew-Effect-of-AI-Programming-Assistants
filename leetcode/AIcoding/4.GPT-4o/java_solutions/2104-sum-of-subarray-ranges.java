class Solution {
    public long subarrayRanges(int[] nums) {
        long result = 0;
        int n = nums.length;

        for (int i = 0; i < n; i++) {
            long max = nums[i];
            long min = nums[i];
            for (int j = i; j < n; j++) {
                max = Math.max(max, nums[j]);
                min = Math.min(min, nums[j]);
                result += max - min;
            }
        }

        return result;
    }
}