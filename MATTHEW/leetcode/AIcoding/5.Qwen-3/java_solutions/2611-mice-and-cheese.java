public class Solution {

import java.util.*;

public class Solution {
    public int miceAndCheese(int[] reward1, int[] reward2, int k) {
        int n = reward1.length;
        int[][] pairs = new int[n][2];

        for (int i = 0; i < n; i++) {
            pairs[i][0] = reward1[i];
            pairs[i][1] = reward2[i];
        }

        Arrays.sort(pairs, (a, b) -> (b[0] - b[1]) - (a[0] - a[1]));

        int total = 0;
        for (int i = 0; i < n; i++) {
            if (i < k) {
                total += pairs[i][0];
            } else {
                total += pairs[i][1];
            }
        }

        return total;
    }
}
}