public class Solution {

import java.util.*;

public class Solution {
    public int minCoins(int[] coins, int target) {
        Arrays.sort(coins);
        int res = 0;
        int current = 1;
        for (int coin : coins) {
            if (coin > current) {
                break;
            }
            res += current / coin;
            current += coin;
        }
        return res;
    }
}
}