public class Solution {
    public int collectTheCoins(int[] coins) {
        int n = coins.length;
        int left = 0;
        int right = n - 1;

        while (left <= right && coins[left] == 0) {
            left++;
        }

        while (left <= right && coins[right] == 0) {
            right--;
        }

        if (left >= right) {
            return 0;
        }

        int res = 0;
        int[] newCoins = new int[right - left + 1];
        for (int i = 0; i < newCoins.length; i++) {
            newCoins[i] = coins[left + i];
        }

        for (int i = 0; i < newCoins.length; i++) {
            if (newCoins[i] == 1) {
                res++;
            }
        }

        return Math.max(0, res - 1);
    }
}