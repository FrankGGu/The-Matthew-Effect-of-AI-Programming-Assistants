public class Solution {

import java.util.*;

public class Solution {
    public int countSubarrays(int[] nums) {
        int count = 0;
        for (int i = 0; i <= nums.length - 3; i++) {
            int a = nums[i];
            int b = nums[i + 1];
            int c = nums[i + 2];
            if (a == b || b == c || a == c) {
                count++;
            }
        }
        return count;
    }
}
}