import java.util.Arrays;

public class Solution {
    public int maximizeWin(int[] piles, int k) {
        Arrays.sort(piles);
        int n = piles.length;
        int maxWin = 0;
        int j = 0;

        for (int i = 0; i < n; i++) {
            while (j < n && piles[j] - piles[i] <= k) {
                j++;
            }
            maxWin = Math.max(maxWin, j - i);
        }

        return maxWin;
    }
}