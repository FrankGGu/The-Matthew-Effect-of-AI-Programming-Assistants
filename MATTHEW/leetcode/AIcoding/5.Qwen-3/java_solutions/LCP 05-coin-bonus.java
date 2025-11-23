public class Solution {

import java.util.*;

public class CoinBonus {
    public int maxTotalReward(int[] coins) {
        Arrays.sort(coins);
        int max = 0;
        Set<Integer> set = new HashSet<>();
        for (int coin : coins) {
            if (coin > max) {
                max += coin;
            } else {
                set.add(coin);
            }
        }
        for (int coin : set) {
            max += coin;
        }
        return max;
    }
}
}