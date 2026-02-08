public class Solution {

import java.util.*;

public class Solution {
    public int maxPower(int[] stations, int k, int n) {
        int left = 0, right = 1000000000;
        while (left < right) {
            int mid = (left + right + 1) / 2;
            if (canPower(stations, k, mid)) {
                left = mid;
            } else {
                right = mid - 1;
            }
        }
        return left;
    }

    private boolean canPower(int[] stations, int k, int minPower) {
        int n = stations.length;
        int[] prefix = new int[n + 1];
        for (int i = 0; i < n; i++) {
            prefix[i + 1] = prefix[i] + stations[i];
        }

        int[] diff = new int[n + 1];
        int power = 0;
        for (int i = 0; i < n; i++) {
            power += diff[i];
            if (power < minPower) {
                int need = minPower - power;
                if (k <= 0) return false;
                int j = Math.min(i + n, n);
                power += need;
                k--;
                if (j < n) {
                    diff[j] -= need;
                }
            }
        }
        return true;
    }
}
}