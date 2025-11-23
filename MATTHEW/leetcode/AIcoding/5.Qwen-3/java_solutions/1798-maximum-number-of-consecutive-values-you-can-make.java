public class Solution {

import java.util.Arrays;

public class Solution {
    public int findMaximumConsecutiveValues(int[] coins) {
        Arrays.sort(coins);
        int max = 0;
        for (int coin : coins) {
            if (coin > max + 1) {
                break;
            }
            max += coin;
        }
        return max + 1;
    }
}
}