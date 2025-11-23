public class Solution {

import java.util.*;

public class Solution {
    public int findSmallestInteger(int[] nums) {
        Arrays.sort(nums);
        int res = 1;
        for (int num : nums) {
            if (num < res) {
                continue;
            } else if (num == res) {
                res++;
            } else {
                break;
            }
        }
        return res;
    }
}
}