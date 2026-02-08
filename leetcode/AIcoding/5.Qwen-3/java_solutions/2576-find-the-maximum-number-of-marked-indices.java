public class Solution {

import java.util.Arrays;

public class Solution {
    public int maxMarkedIndices(int[] nums) {
        Arrays.sort(nums);
        int n = nums.length;
        int i = 0, j = (n + 1) / 2;
        int count = 0;
        while (i < (n + 1) / 2 && j < n) {
            if (nums[j] > nums[i]) {
                count++;
                i++;
            }
            j++;
        }
        return count * 2;
    }
}
}