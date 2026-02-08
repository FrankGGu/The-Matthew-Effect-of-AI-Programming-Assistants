public class Solution {

import java.util.*;

public class Solution {
    public int minDeletionsToMakeArrayBeautiful(int[] nums) {
        int n = nums.length;
        if (n % 2 != 0) {
            n--;
        }
        int res = 0;
        for (int i = 0; i < n - 1; i += 2) {
            if (nums[i] != nums[i + 1]) {
                res++;
                nums[i + 1] = nums[i];
            }
        }
        return res;
    }
}
}