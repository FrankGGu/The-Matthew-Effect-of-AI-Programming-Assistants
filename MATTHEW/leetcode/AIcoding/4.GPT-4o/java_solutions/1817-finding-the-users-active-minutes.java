import java.util.*;

public class Solution {
    public int[] findingUsersActiveMinutes(int[][] logs, int k) {
        Map<Integer, Set<Integer>> userActivities = new HashMap<>();

        for (int[] log : logs) {
            userActivities.computeIfAbsent(log[0], x -> new HashSet<>()).add(log[1]);
        }

        int[] result = new int[k];
        for (Set<Integer> activities : userActivities.values()) {
            int uam = activities.size();
            if (uam <= k) {
                result[uam - 1]++;
            }
        }

        return result;
    }
}