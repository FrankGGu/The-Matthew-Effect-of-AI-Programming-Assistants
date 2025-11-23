public class Solution {

import java.util.*;

public class Solution {
    public int[] smallestSubarraysWithMaximumBitwiseOR(int[] nums) {
        int n = nums.length;
        int[] result = new int[n];

        for (int i = 0; i < n; i++) {
            int maxOr = nums[i];
            result[i] = 0;
            for (int j = i; j < n; j++) {
                maxOr |= nums[j];
                result[i] = Math.max(result[i], maxOr);
            }
        }

        return result;
    }
}
}