public class Solution {

import java.util.*;

public class Solution {
    public int[] getXValues(int[][] coordinates) {
        Arrays.sort(coordinates, (a, b) -> a[0] - b[0]);
        int n = coordinates.length;
        int[] result = new int[n];
        for (int i = 0; i < n; i++) {
            int x = coordinates[i][0];
            int y = coordinates[i][1];
            int count = 0;
            for (int j = 0; j < n; j++) {
                if (coordinates[j][0] == x) {
                    count++;
                }
            }
            result[i] = count;
        }
        return result;
    }
}
}