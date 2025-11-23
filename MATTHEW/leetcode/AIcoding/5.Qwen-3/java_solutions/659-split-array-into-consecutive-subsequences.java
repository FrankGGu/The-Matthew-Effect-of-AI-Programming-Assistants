public class Solution {

import java.util.*;

public class Solution {
    public boolean isPossible(int[] nums) {
        Map<Integer, Integer> count = new HashMap<>();
        for (int num : nums) {
            count.put(num, count.getOrDefault(num, 0) + 1);
        }

        Map<Integer, Integer> tails = new HashMap<>();

        for (int num : nums) {
            if (count.get(num) == 0) {
                continue;
            }
            if (tails.getOrDefault(num - 1, 0) > 0) {
                tails.put(num - 1, tails.get(num - 1) - 1);
                tails.put(num, tails.getOrDefault(num, 0) + 1);
                count.put(num, count.get(num) - 1);
            } else {
                if (count.getOrDefault(num + 1, 0) > 0 && count.getOrDefault(num + 2, 0) > 0) {
                    count.put(num, count.get(num) - 1);
                    count.put(num + 1, count.get(num + 1) - 1);
                    count.put(num + 2, count.get(num + 2) - 1);
                    tails.put(num + 2, tails.getOrDefault(num + 2, 0) + 1);
                } else {
                    return false;
                }
            }
        }

        return true;
    }
}
}