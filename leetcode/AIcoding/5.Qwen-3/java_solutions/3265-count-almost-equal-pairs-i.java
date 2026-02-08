public class Solution {

import java.util.*;

public class Solution {
    public int countAlmostEqualPairs(int[] nums) {
        int count = 0;
        for (int i = 0; i < nums.length; i++) {
            for (int j = i + 1; j < nums.length; j++) {
                if (isAlmostEqual(nums[i], nums[j])) {
                    count++;
                }
            }
        }
        return count;
    }

    private boolean isAlmostEqual(int a, int b) {
        String sA = String.valueOf(a);
        String sB = String.valueOf(b);
        if (sA.length() != sB.length()) {
            return false;
        }
        int diff = 0;
        for (int i = 0; i < sA.length(); i++) {
            if (sA.charAt(i) != sB.charAt(i)) {
                diff++;
                if (diff > 2) {
                    return false;
                }
            }
        }
        return diff <= 2;
    }
}
}