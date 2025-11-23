class Solution {
    public int maxSumMinProduct(int[] nums) {
        int n = nums.length;
        long[] prefixSum = new long[n + 1];
        for (int i = 0; i < n; i++) {
            prefixSum[i + 1] = prefixSum[i] + nums[i];
        }

        int[] left = new int[n];
        int[] right = new int[n];

        for(int i = 0; i < n; i++) {
            left[i] = i;
            while(left[i] > 0 && nums[left[i] - 1] >= nums[i]) {
                left[i] = left[left[i] - 1];
            }
        }

        for(int i = 0; i < n; i++) {
            right[i] = i;
        }

        for(int i = n - 1; i >= 0; i--) {
            while(right[i] < n - 1 && nums[right[i] + 1] > nums[i]) {
                right[i] = right[right[i] + 1];
            }
        }

        long maxProduct = 0;
        for(int i = 0; i < n; i++) {
            maxProduct = Math.max(maxProduct, (prefixSum[right[i] + 1] - prefixSum[left[i]]) * nums[i]);
        }

        return (int)(maxProduct % 1000000007);
    }
}