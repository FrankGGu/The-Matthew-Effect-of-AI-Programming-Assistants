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

        long posDiff = 0;
        long negDiff = 0;

        for (int i = 0; i < nums1.length; i++) {
            int diff = nums1[i] - nums2[i];
            if (diff % k != 0) {
                return -1;
            }
            if (diff > 0) {
                posDiff += diff;
            } else {
                negDiff += -diff;
            }
        }

        if (posDiff != negDiff) {
            return -1;
        }

        return posDiff / k;
    }
}