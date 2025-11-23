class Solution {
public:
    int maxProfit(vector<int>& inventory, int orders) {
        long long left = 0, right = *max_element(inventory.begin(), inventory.end());
        long long mod = 1e9 + 7;

        while (left < right) {
            long long mid = (left + right + 1) / 2;
            long long totalOrders = 0;

            for (int num : inventory) {
                if (num > mid) {
                    totalOrders += num - mid;
                }
            }

            if (totalOrders >= orders) {
                left = mid;
            } else {
                right = mid - 1;
            }
        }

        long long totalProfit = 0;
        for (int num : inventory) {
            if (num > left) {
                totalProfit = (totalProfit + ((num + left + 1) * (num - left) / 2) % mod) % mod) % mod;
            } else {
                totalProfit = (totalProfit + num) % mod;
            }
        }

        totalProfit = (totalProfit - (orders - (totalOrders + (inventory.size() - 1) * (left + 1))) * (left + 1)) % mod + mod) % mod;

        return totalProfit;
    }
};