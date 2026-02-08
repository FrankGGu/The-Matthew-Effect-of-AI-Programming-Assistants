public class Solution {

import java.util.*;

public class Solution {
    public int[] handleSumQueries(int[] nums1, int[] nums2, int[] queries) {
        int n = nums1.length;
        int[] result = new int[queries.length];
        int index = 0;
        int sum1 = 0;
        for (int num : nums1) {
            sum1 += num;
        }
        for (int i = 0; i < queries.length; i++) {
            int query = queries[i];
            if (query == 1) {
                int idx = nums2[i];
                int val = nums1[idx];
                nums1[idx] = 1 - val;
                sum1 += 1 - 2 * val;
            } else {
                result[index++] = sum1;
            }
        }
        return Arrays.copyOf(result, index);
    }
}
}