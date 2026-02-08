public class Solution {

import java.util.*;

public class Solution {
    public int continuousSubarrays(int[] nums) {
        int n = nums.length;
        int count = 0;
        for (int i = 0; i < n; i++) {
            int min = nums[i];
            int max = nums[i];
            for (int j = i; j < n; j++) {
                min = Math.min(min, nums[j]);
                max = Math.max(max, nums[j]);
                if (max - min <= 0) {
                    count++;
                }
            }
        }
        return count;
    }
}
}