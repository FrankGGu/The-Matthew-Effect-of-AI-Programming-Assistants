public class Solution {

import java.util.*;

public class Solution {
    public int maxConsecutive(int[] nums, int x) {
        Arrays.sort(nums);
        int res = 0;
        int prev = -1;
        for (int num : nums) {
            if (prev == -1 || num - prev <= x) {
                res++;
                prev = num;
            } else {
                int count = 1;
                int i = 0;
                while (i < nums.length && nums[i] < prev) {
                    i++;
                }
                while (i < nums.length && nums[i] - prev <= x) {
                    count++;
                    i++;
                }
                res = Math.max(res, count);
                prev = nums[i];
            }
        }
        return res;
    }
}
}