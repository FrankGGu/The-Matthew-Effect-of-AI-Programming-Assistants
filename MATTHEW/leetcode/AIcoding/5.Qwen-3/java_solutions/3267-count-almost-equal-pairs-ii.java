public class Solution {

import java.util.*;

public class Solution {
    public int countAlmostEqualPairs(int[] nums) {
        int n = nums.length;
        int count = 0;
        for (int i = 0; i < n; i++) {
            for (int j = i + 1; j < n; j++) {
                if (isAlmostEqual(nums[i], nums[j])) {
                    count++;
                }
            }
        }
        return count;
    }

    private boolean isAlmostEqual(int a, int b) {
        int diff = 0;
        while (a > 0 || b > 0) {
            int digitA = a % 10;
            int digitB = b % 10;
            if (digitA != digitB) {
                diff++;
            }
            a /= 10;
            b /= 10;
            if (diff > 2) {
                return false;
            }
        }
        return diff <= 2;
    }
}
}