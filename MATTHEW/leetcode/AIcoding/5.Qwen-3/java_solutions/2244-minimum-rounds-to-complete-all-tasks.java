public class Solution {

import java.util.*;

public class Solution {
    public int minimumRounds(int[] tasks) {
        Map<Integer, Integer> count = new HashMap<>();
        for (int task : tasks) {
            count.put(task, count.getOrDefault(task, 0) + 1);
        }

        int rounds = 0;
        for (int val : count.values()) {
            if (val == 1) {
                return -1;
            }
            rounds += (val + 2) / 3;
        }
        return rounds;
    }
}
}