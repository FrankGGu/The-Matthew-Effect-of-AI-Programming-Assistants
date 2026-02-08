public class Solution {

import java.util.*;

public class Solution {
    public int missingInteger(int[] nums) {
        int n = nums.length;
        int prefixSum = nums[0];
        for (int i = 1; i < n; i++) {
            if (nums[i] == nums[i - 1] + 1) {
                prefixSum += nums[i];
            } else {
                break;
            }
        }
        int result = prefixSum + 1;
        while (true) {
            boolean found = false;
            for (int num : nums) {
                if (num == result) {
                    found = true;
                    break;
                }
            }
            if (!found) {
                return result;
            }
            result++;
        }
    }
}
}