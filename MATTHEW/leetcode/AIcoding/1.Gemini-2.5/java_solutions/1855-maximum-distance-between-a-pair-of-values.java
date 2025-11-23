class Solution {
    public int maxDistance(int[] nums1, int[] nums2) {
        int i = 0;
        int j = 0;
        int maxDistance = 0;
        int n1 = nums1.length;
        int n2 = nums2.length;

        while (i < n1 && j < n2) {
            if (nums1[i] <= nums2[j]) {
                maxDistance = Math.max(maxDistance, j - i);
                j++;
            } else { // nums1[i] > nums2[j]
                i++;
                // If i advances, j must not fall behind i to maintain i <= j
                // for potential future valid pairs.
                j = Math.max(j, i);
            }
        }

        return maxDistance;
    }
}