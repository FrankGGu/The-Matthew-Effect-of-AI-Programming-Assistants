public class Solution {

import java.util.*;

public class Solution {
    public boolean canReorderDoubledArray(int[] arr) {
        Map<Integer, Integer> count = new HashMap<>();
        for (int num : arr) {
            count.put(num, count.getOrDefault(num, 0) + 1);
        }

        List<Integer> keys = new ArrayList<>(count.keySet());
        Collections.sort(keys);

        for (int key : keys) {
            if (count.get(key) == 0) continue;
            if (key == 0) {
                if (count.get(key) % 2 != 0) return false;
                continue;
            }
            int target = key * 2;
            if (!count.containsKey(target)) return false;
            if (count.get(target) < count.get(key)) return false;
            count.put(target, count.get(target) - count.get(key));
            count.put(key, 0);
        }

        return true;
    }
}
}