public class Solution {

import java.util.*;

public class Solution {
    public int minOperations(int[] nums, int k) {
        int operations = 0;
        for (int num : nums) {
            if (num < k) {
                operations += k - num;
            }
        }
        return operations;
    }
}
}