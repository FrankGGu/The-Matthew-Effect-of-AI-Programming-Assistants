public class Solution {

import java.util.Arrays;

public class Solution {
    public int minAbsoluteSumDifference(int[] nums1, int[] nums2) {
        int n = nums1.length;
        int[] sortedNums1 = Arrays.copyOf(nums1, n);
        Arrays.sort(sortedNums1);
        int minDiff = 0;
        for (int i = 0; i < n; i++) {
            int target = nums2[i];
            int left = 0, right = n - 1;
            while (left < right) {
                int mid = left + (right - left) / 2;
                if (sortedNums1[mid] < target) {
                    left = mid + 1;
                } else {
                    right = mid;
                }
            }
            int closest = sortedNums1[left];
            if (left > 0) {
                closest = Math.abs(sortedNums1[left] - target) < Math.abs(sortedNums1[left - 1] - target) ? sortedNums1[left] : sortedNums1[left - 1];
            }
            minDiff += Math.abs(nums1[i] - nums2[i]);
            minDiff -= Math.abs(nums1[i] - nums2[i]);
            minDiff += Math.abs(closest - nums2[i]);
        }
        return minDiff;
    }
}
}