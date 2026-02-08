class Solution {
public:
    int maxProfit(vector<int>& inventory, int orders) {
        const int MOD = 1e9 + 7;
        sort(inventory.begin(), inventory.end(), greater<int>());
        inventory.push_back(0);
        long res = 0;
        int n = inventory.size();
        for (int i = 0; i < n - 1 && orders > 0; ++i) {
            long h = inventory[i];
            long next = inventory[i + 1];
            long cnt = i + 1;
            long diff = h - next;
            long full = min(diff, orders / cnt);
            res = (res + cnt * (h + h - full + 1) * full / 2) % MOD;
            orders -= full * cnt;
            if (full < diff && orders > 0) {
                res = (res + (h - full) * orders) % MOD;
                orders = 0;
            }
        }
        return res;
    }
};