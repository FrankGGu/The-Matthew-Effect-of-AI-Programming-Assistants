class Solution {
    public int maxManhattanDistance(int[] nums1, int[] nums2, int k) {
        int n = nums1.length;
        int[] diff = new int[n];
        for (int i = 0; i < n; i++) {
            diff[i] = nums1[i] - nums2[i];
        }
        Arrays.sort(diff);
        for (int i = 0; i < k; i++) {
            if (diff[i] < 0) {
                diff[i] = -diff[i];
            } else {
                diff[i] = -diff[i];
            }
        }
        int sum = 0;
        for (int num : diff) {
            sum += Math.abs(num);
        }
        return sum;
    }
}