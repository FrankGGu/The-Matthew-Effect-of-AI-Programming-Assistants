public class Solution {

import java.util.*;

public class Solution {
    public int[] rearrangeArray(int[] nums, int n) {
        int[] positive = new int[n];
        int[] negative = new int[n];
        int p = 0, q = 0;

        for (int num : nums) {
            if (num > 0) {
                positive[p++] = num;
            } else {
                negative[q++] = num;
            }
        }

        int[] result = new int[2 * n];
        p = 0;
        q = 0;

        for (int i = 0; i < 2 * n; i++) {
            if (i % 2 == 0) {
                result[i] = positive[p++];
            } else {
                result[i] = negative[q++];
            }
        }

        return result;
    }
}
}