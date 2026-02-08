public class Solution {

import java.util.*;

public class Solution {
    public int maximumTotalImportance(int[] skills, int[][] roads) {
        int n = skills.length;
        int[] importance = new int[n];

        for (int[] road : roads) {
            importance[road[0]] += skills[road[1]];
            importance[road[1]] += skills[road[0]];
        }

        Arrays.sort(importance);

        int total = 0;
        for (int i = 0; i < n; i++) {
            total += importance[i] * (i + 1);
        }

        return total;
    }
}
}