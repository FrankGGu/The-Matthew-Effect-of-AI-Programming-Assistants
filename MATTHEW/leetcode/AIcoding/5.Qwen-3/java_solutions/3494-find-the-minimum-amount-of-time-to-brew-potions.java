public class Solution {

import java.util.*;

public class Solution {
    public int minimumTimeToBrewPotions(int[] potions, int target) {
        Arrays.sort(potions);
        int left = 0;
        int right = 1000000;
        int result = 0;

        while (left <= right) {
            int mid = left + (right - left) / 2;
            long total = 0;
            for (int p : potions) {
                total += Math.min(mid, p);
                if (total >= target) {
                    break;
                }
            }
            if (total >= target) {
                result = mid;
                right = mid - 1;
            } else {
                left = mid + 1;
            }
        }

        return result;
    }
}
}