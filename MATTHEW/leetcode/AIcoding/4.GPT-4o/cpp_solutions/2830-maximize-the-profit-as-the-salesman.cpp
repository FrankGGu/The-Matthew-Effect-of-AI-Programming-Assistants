class Solution {
public:
    int maxProfit(vector<int>& inventory, int orders) {
        long long low = 0, high = *max_element(inventory.begin(), inventory.end());
        long long mod = 1e9 + 7;

        while (low < high) {
            long long mid = (low + high + 1) / 2;
            long long totalOrders = 0;
            for (int num : inventory) {
                if (num > mid) {
                    totalOrders += num - mid;
                }
            }
            if (totalOrders >= orders) {
                low = mid;
            } else {
                high = mid - 1;
            }
        }

        long long totalProfit = 0;
        for (int num : inventory) {
            if (num > low) {
                totalProfit += (long long)(num + low + 1) * (num - low) / 2;
                totalOrders -= (num - low);
            } else {
                totalProfit += (long long)(num + 1) * num / 2;
            }
            if (totalOrders <= 0) break;
        }

        totalProfit += low * orders;
        return totalProfit % mod;
    }
};