public class Solution {

import java.util.*;

public class Solution {
    public int minOperations(List<Integer> nums, int k) {
        int operations = 0;
        int count = 0;
        int n = nums.size();
        for (int i = n - 1; i >= 0; i--) {
            if (nums.get(i) <= k) {
                count++;
                if (count == k) {
                    return operations;
                }
            }
            operations++;
        }
        return operations;
    }
}
}