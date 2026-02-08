public class Solution {
    public int maximumMultiplicationScore(int[] nums1, int[] nums2) {
        int maxScore = Integer.MIN_VALUE;
        int result = 0;

        for (int i = 0; i < nums1.length; i++) {
            int score = nums1[i] * nums2[i];
            if (score > maxScore) {
                maxScore = score;
                result = i;
            }
        }

        return result;
    }
}