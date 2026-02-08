import java.util.*;

class Solution {
    public int[] longestCommonSuffix(int[] nums1, int[] nums2, int[][] queries) {
        int n = nums1.length;
        int m = nums2.length;
        int q = queries.length;

        int[] result = new int[q];

        for (int i = 0; i < q; i++) {
            int a = queries[i][0];
            int b = queries[i][1];

            int len = 0;
            while (a >= 0 && b >= 0 && nums1[a] == nums2[b]) {
                len++;
                a--;
                b--;
            }
            result[i] = len;
        }

        return result;
    }
}