import java.util.*;

public class Solution {
    public int maxCoins(int[][] piles) {
        Arrays.sort(piles, (a, b) -> Integer.compare(a[0], b[0]));
        int n = piles.length;
        int k = n / 3, maxCoins = 0;
        for (int i = 0; i < k; i++) {
            maxCoins += piles[n - 1 - i][1];
        }
        return maxCoins;
    }
}