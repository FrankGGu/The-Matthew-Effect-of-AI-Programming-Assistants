public class Solution {

import java.util.*;

public class Solution {
    public int[] findingUsersActiveMinutes(int[][] logs, int k) {
        Map<Integer, Set<Integer>> userActivity = new HashMap<>();
        for (int[] log : logs) {
            int userId = log[0];
            int time = log[1];
            userActivity.putIfAbsent(userId, new HashSet<>());
            userActivity.get(userId).add(time);
        }

        int[] result = new int[k];
        for (Map.Entry<Integer, Set<Integer>> entry : userActivity.entrySet()) {
            int minutes = entry.getValue().size();
            if (minutes > 0 && minutes <= k) {
                result[minutes - 1]++;
            }
        }
        return result;
    }
}
}