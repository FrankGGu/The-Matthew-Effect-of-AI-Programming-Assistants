class Solution {
    public long maximumTripletValue(int[] nums) {
        long max = 0;
        int n = nums.length;
        for (int i = 0; i < n; i++) {
            for (int j = i + 1; j < n; j++) {
                for (int k = j + 1; k < n; k++) {
                    long value = (long)(nums[i] - nums[j]) * nums[k];
                    if (value > max) {
                        max = value;
                    }
                }
            }
        }
        return max;
    }
}