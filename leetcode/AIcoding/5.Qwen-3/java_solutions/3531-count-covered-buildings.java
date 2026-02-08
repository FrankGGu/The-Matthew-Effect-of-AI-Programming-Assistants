public class Solution {

import java.util.*;

public class Solution {
    public int countCoveredBuildings(int[][] buildings) {
        int n = buildings.length;
        if (n == 0) return 0;

        Arrays.sort(buildings, (a, b) -> a[0] - b[0]);

        int result = 0;
        int[] prev = buildings[0];
        for (int i = 1; i < n; i++) {
            int[] curr = buildings[i];
            if (curr[1] <= prev[1]) {
                result++;
            } else {
                prev = curr;
            }
        }

        return result;
    }
}
}