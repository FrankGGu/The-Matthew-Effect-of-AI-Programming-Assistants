public class Solution {

import java.util.*;

public class Solution {
    public int maxOperations(int[] nums, int k) {
        Map<Integer, Integer> count = new HashMap<>();
        for (int num : nums) {
            count.put(num, count.getOrDefault(num, 0) + 1);
        }

        int operations = 0;

        for (int num : count.keySet()) {
            int complement = k - num;
            if (complement == num) {
                if (count.get(num) >= 2) {
                    operations += count.get(num) / 2;
                }
            } else if (complement > num && count.containsKey(complement)) {
                operations += Math.min(count.get(num), count.get(complement));
            }
        }

        return operations;
    }
}
}