import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;

class Solution {
    public int[] findingUsersActiveMinutes(int[][] logs, int k) {
        Map<Integer, Set<Integer>> userActivity = new HashMap<>();

        for (int[] log : logs) {
            int userId = log[0];
            int time = log[1];
            userActivity.computeIfAbsent(userId, k_ -> new HashSet<>()).add(time);
        }

        Map<Integer, Integer> uamCounts = new HashMap<>();
        for (Set<Integer> minutes : userActivity.values()) {
            int uam = minutes.size();
            uamCounts.put(uam, uamCounts.getOrDefault(uam, 0) + 1);
        }

        int[] result = new int[k];
        for (int i = 0; i < k; i++) {
            result[i] = uamCounts.getOrDefault(i + 1, 0);
        }

        return result;
    }
}