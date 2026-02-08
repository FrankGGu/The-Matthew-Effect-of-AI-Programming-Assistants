public class Solution {

import java.util.*;

public class Solution {
    public boolean isPossibleDivide(int[] nums, int k) {
        if (nums.length % k != 0) {
            return false;
        }

        Map<Integer, Integer> count = new HashMap<>();
        for (int num : nums) {
            count.put(num, count.getOrDefault(num, 0) + 1);
        }

        List<Integer> keys = new ArrayList<>(count.keySet());
        Collections.sort(keys);

        for (int key : keys) {
            int currentCount = count.get(key);
            if (currentCount == 0) {
                continue;
            }
            for (int i = 0; i < k; i++) {
                int nextNum = key + i;
                if (count.getOrDefault(nextNum, 0) < currentCount) {
                    return false;
                }
                count.put(nextNum, count.get(nextNum) - currentCount);
            }
        }

        return true;
    }
}
}