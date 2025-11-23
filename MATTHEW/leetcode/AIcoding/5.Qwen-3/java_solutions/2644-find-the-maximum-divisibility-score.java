public class Solution {

import java.util.*;

public class Solution {
    public int maxDivisibilityScore(int[] nums, int[] divisors) {
        int maxCount = -1;
        int result = divisors[0];

        for (int d : divisors) {
            int count = 0;
            for (int num : nums) {
                if (num % d == 0) {
                    count++;
                }
            }
            if (count > maxCount || (count == maxCount && d < result)) {
                maxCount = count;
                result = d;
            }
        }

        return result;
    }
}
}