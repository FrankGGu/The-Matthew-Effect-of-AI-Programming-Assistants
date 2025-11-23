public class Solution {

import java.util.*;

public class Solution {
    public int minBouquets(int[] bloomDay, int m, int k) {
        if (m * k > bloomDay.length) return -1;

        int left = 1, right = Arrays.stream(bloomDay).max().getAsInt();

        while (left < right) {
            int mid = left + (right - left) / 2;
            if (canMakeBouquets(bloomDay, m, k, mid)) {
                right = mid;
            } else {
                left = mid + 1;
            }
        }

        return left;
    }

    private boolean canMakeBouquets(int[] bloomDay, int m, int k, int day) {
        int bouquets = 0;
        int consecutive = 0;

        for (int b : bloomDay) {
            if (b <= day) {
                consecutive++;
                if (consecutive == k) {
                    bouquets++;
                    consecutive = 0;
                }
            } else {
                consecutive = 0;
            }
        }

        return bouquets >= m;
    }
}
}