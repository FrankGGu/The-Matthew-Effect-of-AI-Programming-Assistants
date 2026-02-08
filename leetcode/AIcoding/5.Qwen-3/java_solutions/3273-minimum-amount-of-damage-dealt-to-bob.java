public class Solution {

import java.util.*;

public class Solution {
    public int minDamage(int power, int[] damage, int[] health) {
        int n = damage.length;
        int[][] data = new int[n][2];
        for (int i = 0; i < n; i++) {
            data[i][0] = damage[i];
            data[i][1] = health[i];
        }

        Arrays.sort(data, (a, b) -> {
            int rateA = a[0] * b[1];
            int rateB = b[0] * a[1];
            return Integer.compare(rateB, rateA);
        });

        int totalDamage = 0;
        for (int[] d : data) {
            int damageDealt = Math.min(power, d[1]);
            totalDamage += damageDealt * d[0];
            power -= damageDealt;
            if (power == 0) break;
        }

        return totalDamage;
    }
}
}