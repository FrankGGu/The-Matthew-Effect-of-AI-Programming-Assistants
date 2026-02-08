public class Solution {

import java.util.Arrays;

public class Solution {
    public int addedInteger(int[] nums1, int[] nums2) {
        Arrays.sort(nums1);
        Arrays.sort(nums2);
        int diff = nums2[0] - nums1[0];
        for (int i = 1; i < nums1.length; i++) {
            if (nums2[i] - nums1[i] != diff) {
                return -1;
            }
        }
        return diff;
    }
}
}