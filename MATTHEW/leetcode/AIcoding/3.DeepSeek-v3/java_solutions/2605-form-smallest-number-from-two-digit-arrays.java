class Solution {
    public int minNumber(int[] nums1, int[] nums2) {
        Set<Integer> set1 = new HashSet<>();
        Set<Integer> set2 = new HashSet<>();
        for (int num : nums1) {
            set1.add(num);
        }
        for (int num : nums2) {
            set2.add(num);
        }
        int commonMin = Integer.MAX_VALUE;
        for (int num : set1) {
            if (set2.contains(num)) {
                commonMin = Math.min(commonMin, num);
            }
        }
        if (commonMin != Integer.MAX_VALUE) {
            return commonMin;
        }
        int min1 = Integer.MAX_VALUE;
        int min2 = Integer.MAX_VALUE;
        for (int num : nums1) {
            min1 = Math.min(min1, num);
        }
        for (int num : nums2) {
            min2 = Math.min(min2, num);
        }
        return Math.min(min1, min2) * 10 + Math.max(min1, min2);
    }
}