import java.util.Arrays;

public class Solution {
    public int maxCandies(int[] candies, int k) {
        int left = 1, right = Arrays.stream(candies).max().getAsInt(), result = 0;

        while (left <= right) {
            int mid = left + (right - left) / 2;
            if (canDistribute(candies, mid, k)) {
                result = mid;
                left = mid + 1;
            } else {
                right = mid - 1;
            }
        }
        return result;
    }

    private boolean canDistribute(int[] candies, int mid, int k) {
        int count = 0;
        for (int candy : candies) {
            count += candy / mid;
            if (count >= k) return true;
        }
        return false;
    }
}