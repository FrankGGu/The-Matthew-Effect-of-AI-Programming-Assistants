import java.util.Arrays;

class Solution {
    public String minNumber(int[] nums1, int[] nums2) {
        Arrays.sort(nums1);
        Arrays.sort(nums2);

        int i = 0, j = 0;
        while (i < nums1.length && j < nums2.length) {
            if (nums1[i] < nums2[j]) {
                return String.valueOf(nums1[i]) + mergeArrays(nums1, nums2, i + 1, j);
            } else if (nums1[i] > nums2[j]) {
                return String.valueOf(nums2[j]) + mergeArrays(nums1, nums2, i, j + 1);
            } else {
                return String.valueOf(nums1[i]) + mergeArrays(nums1, nums2, i + 1, j + 1);
            }
        }
        return "";
    }

    private String mergeArrays(int[] nums1, int[] nums2, int i, int j) {
        StringBuilder sb = new StringBuilder();
        while (i < nums1.length) {
            sb.append(nums1[i++]);
        }
        while (j < nums2.length) {
            sb.append(nums2[j++]);
        }
        char[] chars = sb.toString().toCharArray();
        Arrays.sort(chars);
        return new String(chars);
    }
}