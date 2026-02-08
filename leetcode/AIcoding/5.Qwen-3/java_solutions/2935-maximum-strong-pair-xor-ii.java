public class Solution {

import java.util.*;

public class Solution {
    public int maximumStrongPairXOR(int[] nums) {
        int max = 0;
        for (int i = 0; i < nums.length; i++) {
            for (int j = i + 1; j < nums.length; j++) {
                if (Math.abs(nums[i] - nums[j]) <= Math.min(nums[i], nums[j])) {
                    max = Math.max(max, nums[i] ^ nums[j]);
                }
            }
        }
        return max;
    }
}
}