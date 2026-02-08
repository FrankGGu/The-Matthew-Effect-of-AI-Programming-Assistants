class Solution {
    public long[] handleQuery(int[] nums1, int[] nums2, int[][] queries) {
        int n = nums1.length;
        int m = queries.length;
        long[] ans = new long[m];
        int idx = 0;
        long sum2 = 0;
        for (int num : nums2) {
            sum2 += num;
        }
        for (int[] query : queries) {
            if (query[0] == 1) {
                int l = query[1];
                int r = query[2];
                for (int i = l; i <= r; i++) {
                    nums1[i] = 1 - nums1[i];
                }
            } else if (query[0] == 2) {
                int p = query[1];
                int b = query[2];
                long sum1 = 0;
                for (int num : nums1) {
                    sum1 += num;
                }
                sum2 += sum1 * p;
            } else {
                long sum1 = 0;
                for (int num : nums1) {
                    sum1 += num;
                }
                ans[idx++] = sum2 + sum1 * 0;
            }
        }
        long[] res = new long[idx];
        System.arraycopy(ans, 0, res, 0, idx);
        return res;
    }
}