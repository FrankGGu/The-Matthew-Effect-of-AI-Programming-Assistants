import java.util.Arrays;

class Solution {
    public int maximumTastiness(int[] price, int k) {
        Arrays.sort(price);
        int n = price.length;
        int low = 0;
        int high = price[n - 1] - price[0];
        int ans = 0;

        while (low <= high) {
            int mid = low + (high - low) / 2;
            if (canAchieveTastiness(price, k, mid)) {
                ans = mid;
                low = mid + 1;
            } else {
                high = mid - 1;
            }
        }
        return ans;
    }

    private boolean canAchieveTastiness(int[] price, int k, int minTastiness) {
        int count = 1;
        int lastPickedPrice = price[0];

        for (int i = 1; i < price.length; i++) {
            if (price[i] - lastPickedPrice >= minTastiness) {
                count++;
                lastPickedPrice = price[i];
            }
            if (count == k) {
                return true;
            }
        }
        return false;
    }
}