public class Solution {

import java.util.*;

public class Solution {
    public boolean canReorderArray(int[] arr) {
        Map<Integer, Integer> count = new HashMap<>();
        for (int num : arr) {
            count.put(num, count.getOrDefault(num, 0) + 1);
        }

        List<Integer> keys = new ArrayList<>(count.keySet());
        Collections.sort(keys);

        for (int num : keys) {
            if (count.get(num) == 0) continue;
            if (num < 0) {
                if (num % 2 != 0) return false;
                int half = num / 2;
                if (count.getOrDefault(half, 0) < count.get(num)) return false;
                count.put(half, count.get(half) - count.get(num));
                count.put(num, 0);
            } else {
                if (count.getOrDefault(2 * num, 0) < count.get(num)) return false;
                count.put(2 * num, count.get(2 * num) - count.get(num));
                count.put(num, 0);
            }
        }

        return true;
    }
}
}