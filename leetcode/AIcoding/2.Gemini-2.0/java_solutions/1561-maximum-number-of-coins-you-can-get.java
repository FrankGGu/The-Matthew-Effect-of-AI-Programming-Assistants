import java.util.Arrays;

class Solution {
    public int maxCoins(int[] piles) {
        Arrays.sort(piles);
        int n = piles.length;
        int coins = 0;
        for (int i = n - 2; i >= n / 3; i -= 2) {
            coins += piles[i];
        }
        return coins;
    }
}