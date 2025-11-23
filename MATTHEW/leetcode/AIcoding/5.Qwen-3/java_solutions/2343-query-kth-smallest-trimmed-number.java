public class Solution {

import java.util.*;

public class Solution {
    public int[] querySmallestTrimmedNumbers(String[] people, int[][] queries) {
        int n = people.length;
        int m = queries.length;
        int[] result = new int[m];

        for (int i = 0; i < m; i++) {
            int k = queries[i][0];
            int t = queries[i][1];
            List<String> trimmed = new ArrayList<>();
            for (String person : people) {
                trimmed.add(person.substring(0, Math.min(t, person.length())));
            }
            Collections.sort(trimmed);
            result[i] = findIndex(people, trimmed.get(k - 1), t);
        }

        return result;
    }

    private int findIndex(String[] people, String target, int t) {
        for (int i = 0; i < people.length; i++) {
            if (people[i].substring(0, Math.min(t, people[i].length())).equals(target)) {
                return i;
            }
        }
        return -1;
    }
}
}