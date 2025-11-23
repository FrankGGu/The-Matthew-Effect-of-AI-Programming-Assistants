import java.util.HashMap;
import java.util.Map;

class Solution {
    public int numTriplets(int[] nums1, int[] nums2) {
        int count = 0;
        count += countTriplets(nums1, nums2);
        count += countTriplets(nums2, nums1);
        return count;
    }

    private int countTriplets(int[] nums1, int[] nums2) {
        int count = 0;
        for (int i = 0; i < nums1.length; i++) {
            long square = (long) nums1[i] * nums1[i];
            Map<Long, Integer> productCount = new HashMap<>();
            for (int j = 0; j < nums2.length; j++) {
                for (int k = j + 1; k < nums2.length; k++) {
                    long product = (long) nums2[j] * nums2[k];
                    if (product == square) {
                        count++;
                    }
                }
            }
        }
        return count;
    }
}