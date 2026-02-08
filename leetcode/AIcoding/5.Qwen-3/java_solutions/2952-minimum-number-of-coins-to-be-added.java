public class Solution {

import java.util.*;

public class Solution {
    public int minimumCoins(int[] coins, int target) {
        Arrays.sort(coins);
        int res = 0;
        int curr = 1;
        int i = 0;
        while (curr <= target) {
            if (i < coins.length && coins[i] <= curr) {
                curr += coins[i];
                i++;
            } else {
                curr += curr;
                res++;
            }
        }
        return res;
    }
}
}