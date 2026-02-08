public class Solution {

import java.util.HashMap;
import java.util.Map;

public class Solution {
    public int numEquivalentPairs(int[][] dominoes) {
        Map<String, Integer> map = new HashMap<>();
        int count = 0;
        for (int[] domino : dominoes) {
            int a = domino[0];
            int b = domino[1];
            if (a > b) {
                int temp = a;
                a = b;
                b = temp;
            }
            String key = a + "," + b;
            map.put(key, map.getOrDefault(key, 0) + 1);
        }
        for (int value : map.values()) {
            if (value >= 2) {
                count += value * (value - 1) / 2;
            }
        }
        return count;
    }
}
}