public class Solution {

import java.util.*;

public class Solution {
    public int minOperations(int[] nums, int k) {
        int xor = 0;
        for (int num : nums) {
            xor ^= num;
        }
        int operations = 0;
        while (xor != k) {
            int lsb = xor & -xor;
            xor ^= lsb;
            operations++;
        }
        return operations;
    }
}
}