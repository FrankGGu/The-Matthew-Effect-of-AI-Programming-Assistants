import java.util.Arrays;

class Solution {
    public int maximumTastiness(int[] price, int k) {
        Arrays.sort(price);
        int low = 0;
        int high = price[price.length - 1] - price[0];
        int ans = 0;

        while (low <= high) {
            int mid = low + (high - low) / 2;
            if (isPossible(price, k, mid)) {
                ans = mid;
                low = mid + 1;
            } else {
                high = mid - 1;
            }
        }

        return ans;
    }

    private boolean isPossible(int[] price, int k, int tastiness) {
        int count = 1;
        int prev = price[0];

        for (int i = 1; i < price.length; i++) {
            if (price[i] - prev >= tastiness) {
                count++;
                prev = price[i];
            }
        }

        return count >= k;
    }
}