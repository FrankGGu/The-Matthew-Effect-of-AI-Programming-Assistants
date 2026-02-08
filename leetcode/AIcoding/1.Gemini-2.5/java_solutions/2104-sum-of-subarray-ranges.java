class Solution {
    public long subArrayRanges(int[] nums) {
        long totalSum = 0;
        int n = nums.length;

        for (int i = 0; i < n; i++) {
            int minVal = nums[i];
            int maxVal = nums[i];
            for (int j = i; j < n; j++) {
                minVal = Math.min(minVal, nums[j]);
                maxVal = Math.max(maxVal, nums[j]);
                totalSum += (maxVal - minVal);
            }
        }
        return totalSum;
    }
}