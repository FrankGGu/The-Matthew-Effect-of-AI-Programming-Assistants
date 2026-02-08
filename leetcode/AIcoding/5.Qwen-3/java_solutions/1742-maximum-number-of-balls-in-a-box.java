public class Solution {

import java.util.HashMap;
import java.util.Map;

public class Solution {
    public int maxBalls(int[] quantity) {
        Map<Integer, Integer> count = new HashMap<>();
        for (int q : quantity) {
            count.put(q, count.getOrDefault(q, 0) + 1);
        }

        int maxBalls = 0;
        for (Map.Entry<Integer, Integer> entry : count.entrySet()) {
            maxBalls = Math.max(maxBalls, entry.getValue());
        }

        return maxBalls;
    }
}
}