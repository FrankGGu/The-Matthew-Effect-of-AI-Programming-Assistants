public class Solution {

import java.util.*;

public class Solution {
    public int maxOperations(int[] nums) {
        int n = nums.length;
        if (n < 2) return 0;

        Map<Integer, Integer> count = new HashMap<>();
        for (int num : nums) {
            count.put(num, count.getOrDefault(num, 0) + 1);
        }

        int operations = 0;
        int targetSum = nums[0] + nums[1];
        int a = nums[0], b = nums[1];

        while (true) {
            if (count.getOrDefault(a, 0) > 0 && count.getOrDefault(b, 0) > 0) {
                count.put(a, count.get(a) - 1);
                count.put(b, count.get(b) - 1);
                operations++;
                if (count.get(a) == 0) count.remove(a);
                if (count.get(b) == 0) count.remove(b);
                if (count.isEmpty()) break;
                List<Integer> keys = new ArrayList<>(count.keySet());
                a = keys.get(0);
                b = keys.get(1);
                if (a + b != targetSum) break;
            } else {
                break;
            }
        }

        return operations;
    }
}
}