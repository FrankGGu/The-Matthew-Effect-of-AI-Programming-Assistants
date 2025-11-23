class Solution {
    public int numTriplets(int[] nums1, int[] nums2) {
        return countTriplets(nums1, nums2) + countTriplets(nums2, nums1);
    }

    private int countTriplets(int[] nums1, int[] nums2) {
        Map<Long, Integer> map = new HashMap<>();
        for (long num : nums1) {
            long square = num * num;
            map.put(square, map.getOrDefault(square, 0) + 1);
        }

        int res = 0;
        for (int j = 0; j < nums2.length; j++) {
            for (int k = j + 1; k < nums2.length; k++) {
                long product = (long) nums2[j] * nums2[k];
                res += map.getOrDefault(product, 0);
            }
        }
        return res;
    }
}