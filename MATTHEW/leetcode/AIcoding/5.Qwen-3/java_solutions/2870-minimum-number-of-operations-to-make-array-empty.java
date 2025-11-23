public class Solution {

import java.util.*;

public class Solution {
    public int minOperations(int[] nums) {
        Map<Integer, Integer> count = new HashMap<>();
        for (int num : nums) {
            count.put(num, count.getOrDefault(num, 0) + 1);
        }

        int operations = 0;
        for (Map.Entry<Integer, Integer> entry : count.entrySet()) {
            int freq = entry.getValue();
            if (freq == 1) {
                return -1;
            }
            operations += freq / 3;
            if (freq % 3 != 0) {
                operations++;
            }
        }
        return operations;
    }
}
}