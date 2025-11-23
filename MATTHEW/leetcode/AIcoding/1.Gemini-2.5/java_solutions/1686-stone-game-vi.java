import java.util.Arrays;
import java.util.Comparator;

class Solution {
    public long stoneGameVI(int[] aliceValues, int[] bobValues) {
        int n = aliceValues.length;

        int[][] stones = new int[n][3]; // [sum_val, alice_val, bob_val]

        for (int i = 0; i < n; i++) {
            stones[i][0] = aliceValues[i] + bobValues[i]; // sum_val
            stones[i][1] = aliceValues[i]; // alice_val
            stones[i][2] = bobValues[i]; // bob_val
        }

        Arrays.sort(stones, new Comparator<int[]>() {
            @Override
            public int compare(int[] a, int[] b) {
                return b[0] - a[0]; // Sort in descending order based on sum_val
            }
        });

        long aliceScore = 0;
        long bobScore = 0;

        for (int i = 0; i < n; i++) {
            if (i % 2 == 0) { // Alice's turn (0-indexed even turns)
                aliceScore += stones[i][1];
            } else { // Bob's turn (0-indexed odd turns)
                bobScore += stones[i][2];
            }
        }

        return aliceScore - bobScore;
    }
}