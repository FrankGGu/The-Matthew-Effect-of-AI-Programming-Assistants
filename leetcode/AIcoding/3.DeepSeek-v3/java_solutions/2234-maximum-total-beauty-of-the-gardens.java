class Solution {
    public long maximumBeauty(int[] flowers, long newFlowers, int target, int full, int partial) {
        Arrays.sort(flowers);
        int n = flowers.length;
        long[] prefix = new long[n + 1];
        for (int i = 0; i < n; i++) {
            prefix[i + 1] = prefix[i] + flowers[i];
        }

        long res = 0;
        int j = 0;
        for (int c = 0; c <= n; c++) {
            long remaining = newFlowers - (target * (long)c - (prefix[n] - prefix[n - c]));
            if (remaining < 0) break;

            if (c == n) {
                res = Math.max(res, (long)full * n);
                break;
            }

            int low = flowers[0], high = target - 1;
            long min = 0;
            while (low <= high) {
                int mid = low + (high - low) / 2;
                int k = findFirstGreater(flowers, n - c, mid);
                long needed = (long)mid * k - prefix[k];
                if (needed <= remaining) {
                    min = mid;
                    low = mid + 1;
                } else {
                    high = mid - 1;
                }
            }
            res = Math.max(res, (long)full * c + (long)partial * min);
        }
        return res;
    }

    private int findFirstGreater(int[] flowers, int len, int val) {
        int left = 0, right = len;
        while (left < right) {
            int mid = left + (right - left) / 2;
            if (flowers[mid] > val) {
                right = mid;
            } else {
                left = mid + 1;
            }
        }
        return left;
    }
}