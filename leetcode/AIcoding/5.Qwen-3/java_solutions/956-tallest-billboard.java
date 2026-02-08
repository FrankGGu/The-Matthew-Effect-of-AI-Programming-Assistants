public class Solution {

import java.util.*;

public class Solution {
    public int tallestBillboard(String s) {
        Map<Integer, Integer> dp = new HashMap<>();
        dp.put(0, 0);
        for (char c : s.toCharArray()) {
            Map<Integer, Integer> newDp = new HashMap<>(dp);
            for (Map.Entry<Integer, Integer> entry : dp.entrySet()) {
                int key = entry.getKey();
                int value = entry.getValue();
                int newKey = key + (c == '+' ? 1 : -1);
                int newValue = value + 1;
                if (newDp.containsKey(newKey)) {
                    newDp.put(newKey, Math.max(newDp.get(newKey), newValue));
                } else {
                    newDp.put(newKey, newValue);
                }
            }
            dp = newDp;
        }
        return dp.getOrDefault(0, 0);
    }
}
}