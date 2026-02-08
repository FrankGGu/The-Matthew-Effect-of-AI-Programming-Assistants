class Solution {
    public int waysToSplit(int[] nums) {
        int n = nums.length;
        int[] prefixSum = new int[n];
        prefixSum[0] = nums[0];
        for (int i = 1; i < n; i++) {
            prefixSum[i] = prefixSum[i - 1] + nums[i];
        }

        int count = 0;
        int mod = 1000000007;

        for (int i = 0; i < n - 2; i++) {
            int left = i + 1;
            int right = n - 2;
            int firstPossible = -1;
            while (left <= right) {
                int mid = left + (right - left) / 2;
                if (prefixSum[i] <= prefixSum[mid] - prefixSum[i]) {
                    firstPossible = mid;
                    right = mid - 1;
                } else {
                    left = mid + 1;
                }
            }

            left = i + 1;
            right = n - 2;
            int lastPossible = -1;
            while (left <= right) {
                int mid = left + (right - left) / 2;
                if (prefixSum[mid] - prefixSum[i] <= prefixSum[n - 1] - prefixSum[mid]) {
                    lastPossible = mid;
                    left = mid + 1;
                } else {
                    right = mid - 1;
                }
            }

            if (firstPossible != -1 && lastPossible != -1 && firstPossible <= lastPossible) {
                count = (count + (lastPossible - firstPossible + 1)) % mod;
            }
        }

        return count;
    }
}