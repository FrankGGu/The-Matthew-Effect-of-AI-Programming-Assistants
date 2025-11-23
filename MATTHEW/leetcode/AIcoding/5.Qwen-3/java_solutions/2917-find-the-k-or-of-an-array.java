public class Solution {

import java.util.*;

public class Solution {
    public int[] findKOr(int[] nums, int k) {
        int maxBit = 0;
        for (int num : nums) {
            maxBit = Math.max(maxBit, Integer.toBinaryString(num).length());
        }

        int[] result = new int[maxBit];
        for (int i = 0; i < maxBit; i++) {
            int count = 0;
            for (int num : nums) {
                if ((num >> i & 1) == 1) {
                    count++;
                }
            }
            if (count >= k) {
                result[i] = 1;
            } else {
                result[i] = 0;
            }
        }
        return result;
    }
}
}