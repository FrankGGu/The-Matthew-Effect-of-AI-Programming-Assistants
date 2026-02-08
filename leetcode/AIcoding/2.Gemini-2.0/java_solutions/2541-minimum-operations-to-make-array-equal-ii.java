class Solution {
    public long minOperations(int[] nums1, int[] nums2, int k) {
        if (k == 0) {
            for (int i = 0; i < nums1.length; i++) {
                if (nums1[i] != nums2[i]) {
                    return -1;
                }
            }
            return 0;
        }

        long posSum = 0;
        long negSum = 0;

        for (int i = 0; i < nums1.length; i++) {
            int diff = nums1[i] - nums2[i];
            if (diff % k != 0) {
                return -1;
            }
            if (diff > 0) {
                posSum += diff / k;
            } else if (diff < 0) {
                negSum += Math.abs(diff) / k;
            }
        }

        if (posSum != negSum) {
            return -1;
        }

        return posSum;
    }
}