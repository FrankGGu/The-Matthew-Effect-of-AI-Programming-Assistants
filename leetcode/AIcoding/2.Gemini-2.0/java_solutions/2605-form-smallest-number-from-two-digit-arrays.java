class Solution {
    public int minNumber(int[] nums1, int[] nums2) {
        int min1 = Integer.MAX_VALUE;
        int min2 = Integer.MAX_VALUE;
        for (int num : nums1) {
            min1 = Math.min(min1, num);
        }
        for (int num : nums2) {
            min2 = Math.min(min2, num);
        }

        for (int num1 : nums1) {
            for (int num2 : nums2) {
                if (num1 == num2) {
                    return num1;
                }
            }
        }

        if (min1 < min2) {
            return min1 * 10 + min2;
        } else {
            return min2 * 10 + min1;
        }
    }
}