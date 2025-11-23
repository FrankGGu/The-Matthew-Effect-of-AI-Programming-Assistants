public class Solution {

import java.util.Arrays;

public class Solution {
    public int minEatingSpeed(int[] piles, int h) {
        int left = 1;
        int right = Arrays.stream(piles).max().orElse(0);

        while (left < right) {
            int mid = (left + right) / 2;
            int hours = 0;
            for (int pile : piles) {
                hours += Math.ceil((double) pile / mid);
            }
            if (hours > h) {
                left = mid + 1;
            } else {
                right = mid;
            }
        }
        return left;
    }
}
}