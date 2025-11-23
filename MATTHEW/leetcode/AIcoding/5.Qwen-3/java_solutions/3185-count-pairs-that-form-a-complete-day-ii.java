public class Solution {

import java.util.*;

public class Solution {
    public int countCompleteDayPairs(int[] hours, int k) {
        Map<Integer, Integer> map = new HashMap<>();
        int count = 0;
        for (int h : hours) {
            int rem = h % k;
            if (map.containsKey(rem)) {
                count += map.get(rem);
            }
            int complement = (k - rem) % k;
            map.put(complement, map.getOrDefault(complement, 0) + 1);
        }
        return count;
    }
}
}