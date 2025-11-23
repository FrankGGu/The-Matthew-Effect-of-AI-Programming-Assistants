class Solution {
    public int numberOfPairs(int[] nums1, int[] nums2, int diff) {
        int n = nums1.length;
        int count = 0;
        for (int i = 0; i < n; i++) {
            for (int j = i + 1; j < n; j++) {
                if (nums1[i] - nums2[i] <= nums1[j] - nums2[j] + diff) {
                    count++;
                }
            }
        }
        return count;
    }
}