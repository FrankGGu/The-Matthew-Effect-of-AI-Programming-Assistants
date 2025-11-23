public class Solution {

import java.util.*;

public class Solution {
    public int[] singleNumber(int[] nums) {
        int xor = 0;
        for (int num : nums) {
            xor ^= num;
        }

        int lowBit = xor & -xor;
        int a = 0, b = 0;

        for (int num : nums) {
            if ((num & lowBit) == 0) {
                a ^= num;
            } else {
                b ^= num;
            }
        }

        return new int[]{a, b};
    }
}
}