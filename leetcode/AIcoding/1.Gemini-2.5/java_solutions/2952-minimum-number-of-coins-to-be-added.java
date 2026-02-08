import java.util.Arrays;

class Solution {
    public int minPatches(int[] coins, int n) {
        long reach = 0;
        int addedCoins = 0;
        int i = 0;

        Arrays.sort(coins);

        while (reach < n) {
            if (i < coins.length && coins[i] <= reach + 1) {
                reach += coins[i];
                i++;
            } else {
                reach += (reach + 1);
                addedCoins++;
            }
        }

        return addedCoins;
    }
}