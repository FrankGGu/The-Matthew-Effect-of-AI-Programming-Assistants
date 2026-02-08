import java.util.Arrays;

class Solution {
    public int minimumAddedCoins(int[] coins, int target) {
        Arrays.sort(coins);
        int count = 0;
        long currentSum = 0;
        int coinIndex = 0;

        while (currentSum < target) {
            if (coinIndex < coins.length && coins[coinIndex] <= currentSum + 1) {
                currentSum += coins[coinIndex];
                coinIndex++;
            } else {
                currentSum += currentSum + 1;
                count++;
            }
        }

        return count;
    }
}