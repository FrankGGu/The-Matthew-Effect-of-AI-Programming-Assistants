public class Solution {

import java.util.Arrays;

public class Solution {
    public boolean isPossibleToPartition(int[] nums, int k) {
        Arrays.sort(nums);
        int n = nums.length;
        for (int i = 0; i < n; i += 2) {
            if (i + 1 < n && nums[i + 1] - nums[i] > k) {
                return false;
            }
        }
        return true;
    }
}
}