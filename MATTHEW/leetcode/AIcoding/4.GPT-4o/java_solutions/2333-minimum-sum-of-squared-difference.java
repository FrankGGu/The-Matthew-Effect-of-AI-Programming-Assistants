import java.util.Arrays;

public class Solution {
    public long minSumSquareDiff(int[] nums1, int[] nums2, int k) {
        int n = nums1.length;
        long[] diffs = new long[n];
        for (int i = 0; i < n; i++) {
            diffs[i] = Math.abs(nums1[i] - nums2[i]);
        }

        Arrays.sort(diffs);

        long left = 0, right = diffs[n - 1], result = 0;

        while (left < right) {
            long mid = left + (right - left) / 2;
            long sum = 0;
            for (long diff : diffs) {
                sum += Math.max(0, diff - mid);
            }
            if (sum <= k) {
                right = mid;
            } else {
                left = mid + 1;
            }
        }

        long excess = 0;
        for (long diff : diffs) {
            excess += Math.max(0, diff - left);
        }

        long ans = 0;
        for (long diff : diffs) {
            long use = Math.min(k, Math.max(0, diff - left));
            ans += (diff - use) * (diff - use);
            k -= use;
        }

        if (k > 0) {
            ans += k * k;
        }

        return ans;
    }
}