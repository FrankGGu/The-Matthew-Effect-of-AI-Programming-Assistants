public class Solution {

import java.util.*;

public class Solution {
    public int[] getFinalState(int[] nums, int k, int x) {
        int n = nums.length;
        for (int i = 0; i < k; i++) {
            Arrays.sort(nums);
            for (int j = 0; j < n; j++) {
                if (j % 2 == 0) {
                    nums[j] ^= x;
                }
            }
        }
        return nums;
    }
}
}