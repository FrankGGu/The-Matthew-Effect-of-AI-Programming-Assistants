import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;

public class Solution {
    public int unhappyFriends(int n, int[][] preferences, int[][] pairs) {
        Map<Integer, HashSet<Integer>> preferenceMap = new HashMap<>();
        for (int i = 0; i < n; i++) {
            preferenceMap.put(i, new HashSet<>());
            for (int j : preferences[i]) {
                preferenceMap.get(i).add(j);
            }
        }

        int[] partner = new int[n];
        for (int[] pair : pairs) {
            partner[pair[0]] = pair[1];
            partner[pair[1]] = pair[0];
        }

        int unhappyCount = 0;
        for (int i = 0; i < n; i++) {
            int currentPartner = partner[i];
            for (int friend : preferenceMap.get(i)) {
                if (friend == currentPartner) break;
                if (preferenceMap.get(friend).contains(i) && partner[friend] != i) {
                    unhappyCount++;
                    break;
                }
            }
        }

        return unhappyCount;
    }
}