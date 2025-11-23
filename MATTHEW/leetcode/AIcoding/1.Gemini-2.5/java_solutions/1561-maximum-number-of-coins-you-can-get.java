import java.util.Arrays;

class Solution {
    public int maxCoins(int[] piles) {
        Arrays.sort(piles);
        int myCoins = 0;
        int n = piles.length / 3;

        for (int i = 0; i < n; i++) {
            myCoins += piles[piles.length - 2 - 2 * i];
        }

        return myCoins;
    }
}