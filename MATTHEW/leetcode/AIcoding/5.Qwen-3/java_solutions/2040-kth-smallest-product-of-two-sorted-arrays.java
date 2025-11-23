public class Solution {
    public long kthSmallestProduct(int[] A, int[] B, long k) {
        long left = -10000000000L, right = 10000000000L;
        while (left < right) {
            long mid = left + (right - left) / 2;
            long count = countLessEqual(A, B, mid);
            if (count < k) {
                left = mid + 1;
            } else {
                right = mid;
            }
        }
        return left;
    }

    private long countLessEqual(int[] A, int[] B, long target) {
        long count = 0;
        int j = B.length - 1;
        for (int i = 0; i < A.length; ++i) {
            if (A[i] == 0) {
                if (target >= 0) {
                    count += B.length;
                }
                continue;
            }
            int sign = A[i] > 0 ? 1 : -1;
            long t = target;
            if (sign == 1) {
                long l = 0, r = B.length - 1;
                while (l <= r) {
                    long m = l + (r - l) / 2;
                    if ((long) A[i] * B[(int) m] <= t) {
                        l = m + 1;
                    } else {
                        r = m - 1;
                    }
                }
                count += l;
            } else {
                long l = 0, r = B.length - 1;
                while (l <= r) {
                    long m = l + (r - l) / 2;
                    if ((long) A[i] * B[(int) m] <= t) {
                        r = m - 1;
                    } else {
                        l = m + 1;
                    }
                }
                count += B.length - l;
            }
        }
        return count;
    }
}