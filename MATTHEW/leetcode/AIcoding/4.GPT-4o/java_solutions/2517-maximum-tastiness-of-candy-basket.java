import java.util.Arrays;

public class Solution {
    public int maximumTastiness(int[] price, int k) {
        Arrays.sort(price);
        int left = 0, right = price[price.length - 1] - price[0];

        while (left < right) {
            int mid = left + (right - left + 1) / 2;
            if (canDistribute(price, k, mid)) {
                left = mid;
            } else {
                right = mid - 1;
            }
        }

        return left;
    }

    private boolean canDistribute(int[] price, int k, int minTastiness) {
        int count = 1, lastSelected = price[0];

        for (int i = 1; i < price.length; i++) {
            if (price[i] - lastSelected >= minTastiness) {
                count++;
                lastSelected = price[i];
            }
        }

        return count >= k;
    }
}