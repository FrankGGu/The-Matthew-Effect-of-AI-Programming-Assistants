class Solution {
    public int minAbsoluteSumDiff(int[] nums1, int[] nums2) {
        int mod = (int) 1e9 + 7;
        int n = nums1.length;
        int[] sorted = nums1.clone();
        Arrays.sort(sorted);
        long sum = 0;
        int maxDiff = 0;

        for (int i = 0; i < n; i++) {
            int diff = Math.abs(nums1[i] - nums2[i]);
            sum += diff;
            int closest = findClosest(sorted, nums2[i]);
            int newDiff = Math.abs(closest - nums2[i]);
            if (newDiff < diff) {
                maxDiff = Math.max(maxDiff, diff - newDiff);
            }
        }

        return (int) ((sum - maxDiff) % mod);
    }

    private int findClosest(int[] sorted, int target) {
        int left = 0, right = sorted.length - 1;
        while (left < right) {
            int mid = left + (right - left) / 2;
            if (sorted[mid] < target) {
                left = mid + 1;
            } else {
                right = mid;
            }
        }
        int closest = sorted[left];
        if (left > 0 && Math.abs(sorted[left - 1] - target) < Math.abs(closest - target)) {
            closest = sorted[left - 1];
        }
        return closest;
    }
}