public class Solution {

import java.util.*;

public class Solution {
    public int unhappyFriends(int n, int[][] preferences, int[][] pairs) {
        Map<Integer, Set<Integer>> preferenceMap = new HashMap<>();
        for (int i = 0; i < n; i++) {
            preferenceMap.put(i, new HashSet<>());
            for (int j = 0; j < preferences[i].length; j++) {
                preferenceMap.get(i).add(preferences[i][j]);
            }
        }

        Set<Integer> pairSet = new HashSet<>();
        for (int[] pair : pairs) {
            pairSet.add(pair[0]);
            pairSet.add(pair[1]);
        }

        Set<Integer> unhappy = new HashSet<>();

        for (int[] pair : pairs) {
            int a = pair[0];
            int b = pair[1];

            for (int i = 0; i < preferences[a].length; i++) {
                int person = preferences[a][i];
                if (person == b) break;
                if (pairSet.contains(person)) {
                    if (preferenceMap.get(person).contains(a)) {
                        unhappy.add(a);
                        break;
                    }
                }
            }

            for (int i = 0; i < preferences[b].length; i++) {
                int person = preferences[b][i];
                if (person == a) break;
                if (pairSet.contains(person)) {
                    if (preferenceMap.get(person).contains(b)) {
                        unhappy.add(b);
                        break;
                    }
                }
            }
        }

        return unhappy.size();
    }
}
}