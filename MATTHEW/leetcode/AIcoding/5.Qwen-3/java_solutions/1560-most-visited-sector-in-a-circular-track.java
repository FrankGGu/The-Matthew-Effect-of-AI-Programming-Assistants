public class Solution {

import java.util.*;

public class Solution {
    public List<Integer> mostVisited(int n, int[] rounds) {
        List<Integer> result = new ArrayList<>();
        int[] count = new int[n + 1];
        int start = rounds[0];
        int end = rounds[rounds.length - 1];

        for (int i = 0; i < rounds.length; i++) {
            int current = rounds[i];
            count[current]++;
        }

        int max = 0;
        for (int i = 1; i <= n; i++) {
            if (count[i] > max) {
                max = count[i];
            }
        }

        for (int i = 1; i <= n; i++) {
            if (count[i] == max) {
                result.add(i);
            }
        }

        return result;
    }
}
}