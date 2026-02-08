public class Solution {

import java.util.*;

public class Solution {
    public int[] maxXorScore(int[] nums, int[][] queries) {
        int n = nums.length;
        int[] prefixXor = new int[n];
        prefixXor[0] = nums[0];
        for (int i = 1; i < n; i++) {
            prefixXor[i] = prefixXor[i - 1] ^ nums[i];
        }

        int[] result = new int[queries.length];
        for (int i = 0; i < queries.length; i++) {
            int l = queries[i][0];
            int r = queries[i][1];
            if (l == 0) {
                result[i] = prefixXor[r];
            } else {
                result[i] = prefixXor[r] ^ prefixXor[l - 1];
            }
        }
        return result;
    }
}
}