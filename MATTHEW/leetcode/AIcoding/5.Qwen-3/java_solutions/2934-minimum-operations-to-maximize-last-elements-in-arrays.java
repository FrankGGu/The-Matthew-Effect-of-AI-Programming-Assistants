public class Solution {

import java.util.*;

public class Solution {
    public int minOperations(int[] nums1, int[] nums2) {
        int n = nums1.length;
        int m = nums2.length;
        int i = n - 1, j = m - 1;
        int ops = 0;

        while (i >= 0 && j >= 0) {
            if (nums1[i] == nums2[j]) {
                i--;
                j--;
            } else if (nums1[i] > nums2[j]) {
                ops++;
                i--;
            } else {
                ops++;
                j--;
            }
        }

        while (i >= 0) {
            ops++;
            i--;
        }

        while (j >= 0) {
            ops++;
            j--;
        }

        return ops;
    }
}
}