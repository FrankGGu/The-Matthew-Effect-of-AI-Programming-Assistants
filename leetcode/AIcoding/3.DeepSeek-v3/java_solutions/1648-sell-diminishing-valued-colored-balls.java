class Solution {
    public int maxProfit(int[] inventory, int orders) {
        Arrays.sort(inventory);
        int n = inventory.length;
        long res = 0;
        int mod = 1000000007;
        int cur = inventory[n - 1];
        int i = n - 1;
        while (orders > 0) {
            while (i >= 0 && inventory[i] == cur) {
                i--;
            }
            int next = i == -1 ? 0 : inventory[i];
            int count = n - 1 - i;
            int diff = cur - next;
            long total = (long) count * diff;
            if (total <= orders) {
                res += (long) (cur + next + 1) * diff / 2 * count;
                orders -= total;
            } else {
                int full = orders / count;
                int rem = orders % count;
                res += (long) (cur + cur - full + 1) * full / 2 * count;
                res += (long) (cur - full) * rem;
                orders = 0;
            }
            res %= mod;
            cur = next;
        }
        return (int) (res % mod);
    }
}