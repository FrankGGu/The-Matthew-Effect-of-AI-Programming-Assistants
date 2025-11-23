class Solution {
    public int maximumTop(int[] nums, int k) {
        int n = nums.length;
        if (n == 1) {
            return (k % 2 == 0) ? nums[0] : -1;
        }

        if (k > n) {
            int maxVal = -1;
            for (int num : nums) {
                maxVal = Math.max(maxVal, num);
            }
            return maxVal;
        }

        if (k == n) {
            int maxVal = -1;
            for (int i = 0; i < n - 1; i++) {
                maxVal = Math.max(maxVal, nums[i]);
            }
            return maxVal;
        }

        int maxVal = -1;
        for (int i = 0; i < Math.min(k - 1, n); i++) {
            maxVal = Math.max(maxVal, nums[i]);
        }

        if(k < n){
            maxVal = Math.max(maxVal, nums[k]);
        }

        return maxVal;
    }
}