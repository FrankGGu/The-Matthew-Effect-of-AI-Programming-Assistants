public class Solution {

import java.util.*;

public class Solution {
    public int maxKSumPairs(int[] nums, int k) {
        Map<Integer, Integer> count = new HashMap<>();
        int result = 0;

        for (int num : nums) {
            int complement = k - num;
            if (count.containsKey(complement)) {
                result++;
                count.put(complement, count.get(complement) - 1);
                if (count.get(complement) == 0) {
                    count.remove(complement);
                }
                count.put(num, count.getOrDefault(num, 0) + 1);
            } else {
                count.put(num, count.getOrDefault(num, 0) + 1);
            }
        }

        return result;
    }
}
}