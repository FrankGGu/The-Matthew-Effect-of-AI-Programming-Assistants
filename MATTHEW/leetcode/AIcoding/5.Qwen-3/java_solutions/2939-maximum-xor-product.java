public class Solution {
    public long maxXorProduct(long[] nums1, long[] nums2) {
        int n = nums1.length;
        int m = nums2.length;
        long[] a = new long[n];
        long[] b = new long[m];
        System.arraycopy(nums1, 0, a, 0, n);
        System.arraycopy(nums2, 0, b, 0, m);

        java.util.Arrays.sort(a);
        java.util.Arrays.sort(b);

        long res = 0;
        long x = 0;
        int i = n - 1, j = m - 1;

        while (i >= 0 || j >= 0) {
            long val1 = i >= 0 ? a[i] : 0;
            long val2 = j >= 0 ? b[j] : 0;

            if (val1 > val2) {
                x ^= val1;
                i--;
            } else {
                x ^= val2;
                j--;
            }

            if (x > res) {
                res = x;
            }
        }

        return res;
    }
}