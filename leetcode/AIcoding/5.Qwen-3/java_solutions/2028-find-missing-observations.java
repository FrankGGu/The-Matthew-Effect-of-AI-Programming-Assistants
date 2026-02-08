public class Solution {

import java.util.*;

public class Solution {
    public int[] missingRolls(int[] rolls, int mean, int n) {
        int m = rolls.length;
        int total = 0;
        for (int roll : rolls) {
            total += roll;
        }
        int required = mean * (n + m) - total;
        if (required < n || required > 6 * n) {
            return new int[0];
        }
        int[] result = new int[n];
        int avg = required / n;
        int rem = required % n;
        for (int i = 0; i < n; i++) {
            result[i] = avg + (i < rem ? 1 : 0);
        }
        return result;
    }
}
}