public class Solution {

import java.util.*;

public class Solution {
    public boolean isPossibleToCatchAll(int[][] positions, int speed) {
        int n = positions.length;
        List<int[]> list = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            list.add(new int[]{positions[i][0], positions[i][1], i});
        }
        list.sort((a, b) -> a[0] != b[0] ? a[0] - b[0] : a[1] - b[1]);

        int[] time = new int[n];
        for (int i = 0; i < n; i++) {
            int x = list.get(i)[0];
            int y = list.get(i)[1];
            int idx = list.get(i)[2];
            time[idx] = (int) Math.ceil((double) y / speed);
        }

        for (int i = 0; i < n; i++) {
            int x = list.get(i)[0];
            int y = list.get(i)[1];
            int idx = list.get(i)[2];
            if (i > 0 && x == list.get(i - 1)[0]) {
                if (time[idx] <= time[list.get(i - 1)[2]]) {
                    return false;
                }
            }
        }

        return true;
    }
}
}