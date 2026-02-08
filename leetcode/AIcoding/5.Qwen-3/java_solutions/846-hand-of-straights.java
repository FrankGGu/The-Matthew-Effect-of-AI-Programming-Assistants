public class Solution {

import java.util.*;

public class Solution {
    public boolean isPossibleDivide(int[] deck, int k) {
        if (deck.length % k != 0) {
            return false;
        }
        Map<Integer, Integer> count = new HashMap<>();
        for (int num : deck) {
            count.put(num, count.getOrDefault(num, 0) + 1);
        }
        List<Integer> keys = new ArrayList<>(count.keySet());
        Collections.sort(keys);
        for (int key : keys) {
            int c = count.get(key);
            if (c == 0) continue;
            for (int i = 0; i < k; i++) {
                int next = key + i;
                if (count.getOrDefault(next, 0) < c) {
                    return false;
                }
                count.put(next, count.get(next) - c);
            }
        }
        return true;
    }
}
}