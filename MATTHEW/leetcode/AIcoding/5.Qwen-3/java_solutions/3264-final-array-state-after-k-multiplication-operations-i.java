public class Solution {

import java.util.Arrays;

public class Solution {
    public int[] getResultArray(int[] nums, int k, int[][] queries) {
        int n = nums.length;
        int[] result = new int[n];
        for (int i = 0; i < n; i++) {
            result[i] = nums[i];
        }
        for (int[] query : queries) {
            int index = query[0];
            int operation = query[1];
            if (operation == 1) {
                for (int i = 0; i < k; i++) {
                    result[index] *= 2;
                }
            } else if (operation == 2) {
                for (int i = 0; i < k; i++) {
                    result[index] /= 2;
                }
            }
        }
        return result;
    }
}
}