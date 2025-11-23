public class Solution {

import java.util.*;

public class Solution {
    public int minDominoRotations(int[] top, int[] bottom) {
        int n = top.length;
        int[] countTop = new int[7];
        int[] countBottom = new int[7];
        int[] same = new int[7];

        for (int i = 0; i < n; i++) {
            countTop[top[i]]++;
            countBottom[bottom[i]]++;
            if (top[i] == bottom[i]) {
                same[top[i]]++;
            }
        }

        int minRotations = Integer.MAX_VALUE;
        for (int i = 1; i <= 6; i++) {
            if (countTop[i] + countBottom[i] == n) {
                minRotations = Math.min(minRotations, Math.min(countTop[i], countBottom[i]) - same[i]);
            }
        }

        return minRotations == Integer.MAX_VALUE ? -1 : minRotations;
    }
}
}