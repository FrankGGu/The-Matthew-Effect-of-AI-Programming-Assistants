public class Solution {

import java.util.*;

public class Solution {
    public int maxNonDecreasingSubarray(int[] nums1, int[] nums2) {
        int n = nums1.length;
        int maxLen = 1;
        int currentLen = 1;

        for (int i = 1; i < n; i++) {
            if (nums1[i] >= nums1[i - 1] && nums2[i] >= nums2[i - 1]) {
                currentLen++;
            } else if (nums1[i] >= nums2[i - 1]) {
                currentLen = 2;
            } else if (nums2[i] >= nums1[i - 1]) {
                currentLen = 2;
            } else {
                currentLen = 1;
            }
            maxLen = Math.max(maxLen, currentLen);
        }

        return maxLen;
    }
}
}