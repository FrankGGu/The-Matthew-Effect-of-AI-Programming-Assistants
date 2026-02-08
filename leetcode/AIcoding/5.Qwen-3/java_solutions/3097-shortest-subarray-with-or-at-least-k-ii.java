public class Solution {

import java.util.*;

public class Solution {
    public int[] smallestSubarraysOr(int[] nums, int k) {
        int n = nums.length;
        int[] result = new int[n];

        for (int i = 0; i < n; i++) {
            int orVal = 0;
            for (int j = i; j < n; j++) {
                orVal |= nums[j];
                if (orVal >= k) {
                    result[i] = j - i + 1;
                    break;
                }
            }
        }

        return result;
    }
}
}