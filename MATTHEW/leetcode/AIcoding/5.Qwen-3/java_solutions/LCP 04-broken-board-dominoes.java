public class Solution {

import java.util.*;

public class Solution {
    public int minDominoRotations(int[][] dominoes) {
        int n = dominoes.length;
        Set<Integer> candidates = new HashSet<>();
        candidates.add(dominoes[0][0]);
        candidates.add(dominoes[0][1]);

        for (int i = 0; i < n; i++) {
            Set<Integer> current = new HashSet<>();
            current.add(dominoes[i][0]);
            current.add(dominoes[i][1]);
            candidates.retainAll(current);
            if (candidates.isEmpty()) {
                return -1;
            }
        }

        int minRotations = Integer.MAX_VALUE;
        for (int candidate : candidates) {
            int rotateTop = 0;
            int rotateBottom = 0;
            for (int i = 0; i < n; i++) {
                if (dominoes[i][0] != candidate) {
                    rotateTop++;
                }
                if (dominoes[i][1] != candidate) {
                    rotateBottom++;
                }
            }
            minRotations = Math.min(minRotations, Math.min(rotateTop, rotateBottom));
        }

        return minRotations;
    }
}
}