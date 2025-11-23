public class Solution {

import java.util.*;

public class Solution {
    public int maxTotalFruits(int[][] positions, int k) {
        int n = positions.length;
        Arrays.sort(positions, (a, b) -> a[0] - b[0]);
        int[] pos = new int[n];
        int[] fruits = new int[n];
        for (int i = 0; i < n; i++) {
            pos[i] = positions[i][0];
            fruits[i] = positions[i][1];
        }

        int[] prefix = new int[n + 1];
        for (int i = 0; i < n; i++) {
            prefix[i + 1] = prefix[i] + fruits[i];
        }

        int res = 0;
        for (int i = 0; i < n; i++) {
            for (int j = i; j < n; j++) {
                int left = pos[i];
                int right = pos[j];
                int steps = right - left;
                if (steps <= k) {
                    res = Math.max(res, prefix[j + 1] - prefix[i]);
                } else {
                    int leftSteps = left - pos[0];
                    int rightSteps = pos[n - 1] - right;
                    int extra = Math.min(leftSteps, rightSteps);
                    if (extra + steps <= k) {
                        res = Math.max(res, prefix[j + 1] - prefix[i]);
                    }
                }
            }
        }

        return res;
    }
}
}