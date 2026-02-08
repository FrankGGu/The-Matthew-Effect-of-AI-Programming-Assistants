public class Solution {

import java.util.Arrays;

public class Solution {
    public int maxCoins(int[] piles) {
        Arrays.sort(piles);
        int n = piles.length;
        int result = 0;
        for (int i = n - 2; i >= n / 3; i -= 2) {
            result += piles[i];
        }
        return result;
    }
}
}