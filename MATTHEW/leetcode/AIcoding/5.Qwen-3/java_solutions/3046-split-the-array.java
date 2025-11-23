public class Solution {

import java.util.*;

public class Solution {
    public boolean splitArray(int[] nums) {
        int n = nums.length;
        for (int i = 1; i < n - 1; i++) {
            int leftSum = 0;
            for (int j = 0; j < i; j++) {
                leftSum += nums[j];
            }
            int rightSum = 0;
            for (int j = i + 1; j < n; j++) {
                rightSum += nums[j];
            }
            if (leftSum == rightSum) {
                return true;
            }
        }
        return false;
    }
}
}