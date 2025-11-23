class Solution {
    public long findTheNthValue(long n, long k, int[] nums) {
        int len = nums.length;
        long[] arr = new long[len];
        for (int i = 0; i < len; i++) {
            arr[i] = nums[i];
        }

        for (int i = 0; i < Math.min(k, 1000); i++) {
            long minVal = Long.MAX_VALUE;
            for (long val : arr) {
                minVal = Math.min(minVal, val);
            }

            for (int j = 0; j < len; j++) {
                if (arr[j] == minVal) {
                    arr[j] += n;
                }
            }
        }

        if (k > 1000) {
            long minVal = Long.MAX_VALUE;
            for (long val : arr) {
                minVal = Math.min(minVal, val);
            }

            long count = 0;
            for (long val : arr) {
                if (val == minVal) {
                    count++;
                }
            }

            long remainingK = k - 1000;
            for (int i = 0; i < len; i++) {
                if (arr[i] == minVal) {
                    arr[i] += remainingK * n;
                }
            }
        }

        long ans = Long.MAX_VALUE;
        for (long val : arr) {
            ans = Math.min(ans, val);
        }

        return ans;
    }
}