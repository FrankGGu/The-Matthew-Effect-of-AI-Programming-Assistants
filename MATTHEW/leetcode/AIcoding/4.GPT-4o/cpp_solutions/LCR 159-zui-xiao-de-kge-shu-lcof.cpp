class Solution {
public:
    int maxProfit(vector<int>& inventory, int orders) {
        long long left = 0, right = *max_element(inventory.begin(), inventory.end());
        long long ans = 0, mod = 1e9 + 7;

        while (left < right) {
            long long mid = left + (right - left + 1) / 2;
            long long totalOrders = 0;

            for (int amount : inventory) {
                if (amount > mid) {
                    totalOrders += amount - mid;
                }
            }

            if (totalOrders >= orders) {
                left = mid;
            } else {
                right = mid - 1;
            }
        }

        long long total = 0;
        for (int amount : inventory) {
            if (amount > left) {
                total += (amount - left);
            }
        }

        total = min(total, (long long)orders);
        long long result = (left * (total + orders)) % mod;
        result = (result + (total * (total + 1) / 2) % mod) % mod;

        return result;
    }
};