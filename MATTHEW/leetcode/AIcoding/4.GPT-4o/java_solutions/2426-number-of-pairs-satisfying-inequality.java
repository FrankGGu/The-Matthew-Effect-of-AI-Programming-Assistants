import java.util.Arrays;

class Solution {
    public int countPairs(int[] nums1, int[] nums2, int diff) {
        int n = nums1.length;
        int[] diffs = new int[n];
        for (int i = 0; i < n; i++) {
            diffs[i] = nums1[i] - nums2[i];
        }
        Arrays.sort(diffs);
        int count = 0;
        for (int i = 0; i < n; i++) {
            count += upperBound(diffs, diffs[i] + diff);
        }
        return count;
    }

    private int upperBound(int[] diffs, int target) {
        int left = 0, right = diffs.length;
        while (left < right) {
            int mid = left + (right - left) / 2;
            if (diffs[mid] <= target) {
                left = mid + 1;
            } else {
                right = mid;
            }
        }
        return left;
    }
}