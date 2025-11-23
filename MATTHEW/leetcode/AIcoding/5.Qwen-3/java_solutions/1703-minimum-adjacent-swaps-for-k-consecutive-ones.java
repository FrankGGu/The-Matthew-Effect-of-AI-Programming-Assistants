public class Solution {

import java.util.*;

public class Solution {
    public int minAdjSwapsForKConsecutive(int[] nums, int k) {
        List<Integer> indices = new ArrayList<>();
        for (int i = 0; i < nums.length; i++) {
            if (nums[i] == 1) {
                indices.add(i);
            }
        }

        int n = indices.size();
        int res = Integer.MAX_VALUE;

        for (int i = 0; i + k - 1 < n; i++) {
            int[] sub = new int[k];
            for (int j = 0; j < k; j++) {
                sub[j] = indices.get(i + j);
            }

            int swaps = 0;
            int mid = k / 2;
            for (int j = 0; j < k; j++) {
                swaps += Math.abs(sub[j] - sub[mid]);
            }

            res = Math.min(res, swaps);
        }

        return res;
    }
}
}