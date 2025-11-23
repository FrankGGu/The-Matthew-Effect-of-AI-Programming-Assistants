public class Solution {

import java.util.*;

public class Solution {
    public int[] sumDistance(int[] houses, int[] workers) {
        Arrays.sort(houses);
        Arrays.sort(workers);
        int n = houses.length;
        int[] res = new int[n];
        for (int i = 0; i < n; i++) {
            res[i] = Math.abs(houses[i] - workers[i]);
        }
        return res;
    }
}
}