public class Solution {

import java.util.*;

public class Solution {
    public int maxSumObtained(int[] nums) {
        Arrays.sort(nums);
        int sum = 0;
        for (int i = 0; i < nums.length; i++) {
            sum += nums[i] * (i + 1);
        }
        return sum;
    }
}
}