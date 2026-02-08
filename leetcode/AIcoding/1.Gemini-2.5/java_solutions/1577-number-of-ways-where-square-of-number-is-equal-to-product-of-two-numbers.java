import java.util.HashMap;
import java.util.Map;

class Solution {
    public int numTriplets(int[] nums1, int[] nums2) {
        return countTriplets(nums1, nums2) + countTriplets(nums2, nums1);
    }

    private int countTriplets(int[] arr1, int[] arr2) {
        Map<Long, Integer> productFreq = new HashMap<>();
        for (int j = 0; j < arr2.length; j++) {
            for (int k = j; k < arr2.length; k++) {
                long product = (long) arr2[j] * arr2[k];
                productFreq.put(product, productFreq.getOrDefault(product, 0) + 1);
            }
        }

        int count = 0;
        for (int i = 0; i < arr1.length; i++) {
            long square = (long) arr1[i] * arr1[i];
            count += productFreq.getOrDefault(square, 0);
        }
        return count;
    }
}