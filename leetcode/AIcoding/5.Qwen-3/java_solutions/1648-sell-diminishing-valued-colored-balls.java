public class Solution {

import java.util.*;

public class Solution {
    public int maxProfit(int[] inventory, int orders) {
        Arrays.sort(inventory);
        long res = 0;
        int mod = (int) 1e9 + 7;
        int n = inventory.length;
        for (int i = n - 1; i >= 0 && orders > 0; i--) {
            int cnt = 1;
            if (i < n - 1) {
                cnt = i == 0 ? n : n - i;
            }
            int next = i == 0 ? 0 : inventory[i - 1];
            long diff = inventory[i] - next;
            long total = diff * cnt;
            if (total <= orders) {
                res += (diff * (inventory[i] + next + 1)) / 2 * cnt;
                res %= mod;
                orders -= (int) total;
            } else {
                long k = orders / cnt;
                long r = orders % cnt;
                res += (k * (2 * inventory[i] - k + 1)) / 2 * cnt;
                res += (long) r * (inventory[i] - k);
                res %= mod;
                orders = 0;
            }
        }
        return (int) res;
    }
}
}