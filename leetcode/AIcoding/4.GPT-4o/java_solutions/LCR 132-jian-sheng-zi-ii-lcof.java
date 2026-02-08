import java.util.Arrays;

public class Solution {
    public int minDays(int[] bloomDay, int m, int k) {
        if (m * k > bloomDay.length) return -1;

        int left = Arrays.stream(bloomDay).min().getAsInt();
        int right = Arrays.stream(bloomDay).max().getAsInt();

        while (left < right) {
            int mid = left + (right - left) / 2;
            if (canMakeBouquets(bloomDay, mid, m, k)) {
                right = mid;
            } else {
                left = mid + 1;
            }
        }
        return left;
    }

    private boolean canMakeBouquets(int[] bloomDay, int day, int m, int k) {
        int count = 0;
        int flowers = 0;

        for (int bloom : bloomDay) {
            if (bloom <= day) {
                flowers++;
                if (flowers == k) {
                    count++;
                    flowers = 0;
                }
            } else {
                flowers = 0;
            }
        }
        return count >= m;
    }
}