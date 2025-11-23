public class Solution {

import java.util.*;

public class Solution {
    public int[] replaceElements(int[] nums) {
        int max = nums[nums.length - 1];
        nums[nums.length - 1] = -1;
        for (int i = nums.length - 2; i >= 0; i--) {
            int temp = nums[i];
            nums[i] = max;
            max = Math.max(max, temp);
        }
        return nums;
    }
}
}