public class Solution {

import java.util.*;

public class Solution {
    public int colorTheArray(int n, int k) {
        int[] nums = new int[n];
        Arrays.fill(nums, 0);
        int res = 0;
        for (int i = 1; i < n; i++) {
            if (nums[i] == nums[i - 1]) {
                res++;
            }
        }
        return res;
    }
}
}