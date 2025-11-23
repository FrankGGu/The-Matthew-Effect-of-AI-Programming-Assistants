class Solution {
    public int maximumTripletValue(int[] nums) {
        int max = 0;
        int n = nums.length;
        for (int j = 1; j < n - 1; j++) {
            int max1 = Integer.MIN_VALUE, max2 = Integer.MIN_VALUE;
            for (int i = 0; i < j; i++) {
                max1 = Math.max(max1, nums[i]);
            }
            for (int k = j + 1; k < n; k++) {
                max2 = Math.max(max2, nums[k]);
            }
            max = Math.max(max, max1 - nums[j] + max2);
        }
        return max;
    }
}