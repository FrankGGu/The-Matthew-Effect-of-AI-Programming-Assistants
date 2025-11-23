class Solution {
    public int waysToSplit(int[] nums) {
        int n = nums.length;
        long[] prefix = new long[n + 1];
        for (int i = 0; i < n; i++) {
            prefix[i + 1] = prefix[i] + nums[i];
        }

        int count = 0;
        for (int j = 1; j < n; j++) {
            long leftSum = prefix[j];
            int low = j + 1, high = n;
            while (low < high) {
                int mid = low + (high - low) / 2;
                if (prefix[mid] - leftSum < leftSum) {
                    low = mid + 1;
                } else {
                    high = mid;
                }
            }
            int leftBound = low;
            low = j + 1;
            high = n;
            while (low < high) {
                int mid = low + (high - low) / 2;
                if (prefix[n] - prefix[mid] < leftSum) {
                    high = mid;
                } else {
                    low = mid + 1;
                }
            }
            int rightBound = low;
            count += Math.max(0, rightBound - leftBound);
        }
        return count;
    }
}