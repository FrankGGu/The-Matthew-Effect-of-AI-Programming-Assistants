class Solution {
    public int maxDistance(int[] nums1, int[] nums2) {
        int maxDistance = 0;
        int j = nums2.length - 1;

        for (int i = 0; i < nums1.length; i++) {
            while (j >= 0 && nums2[j] < nums1[i]) {
                j--;
            }
            if (j >= i) {
                maxDistance = Math.max(maxDistance, j - i);
            }
        }

        return maxDistance;
    }
}