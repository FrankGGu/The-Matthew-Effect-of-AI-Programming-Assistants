import java.util.Arrays;
import java.util.PriorityQueue;

class Solution {
    public int stoneGameVI(int[] aliceValues, int[] bobValues) {
        int n = aliceValues.length;
        int[] sum = new int[n];
        for (int i = 0; i < n; i++) {
            sum[i] = aliceValues[i] + bobValues[i];
        }

        Integer[] indices = new Integer[n];
        for (int i = 0; i < n; i++) {
            indices[i] = i;
        }

        Arrays.sort(indices, (a, b) -> sum[b] - sum[a]);

        int aliceScore = 0;
        int bobScore = 0;

        for (int i = 0; i < n; i++) {
            if (i % 2 == 0) {
                aliceScore += aliceValues[indices[i]];
            } else {
                bobScore += bobValues[indices[i]];
            }
        }

        if (aliceScore > bobScore) {
            return 1;
        } else if (aliceScore < bobScore) {
            return -1;
        } else {
            return 0;
        }
    }
}