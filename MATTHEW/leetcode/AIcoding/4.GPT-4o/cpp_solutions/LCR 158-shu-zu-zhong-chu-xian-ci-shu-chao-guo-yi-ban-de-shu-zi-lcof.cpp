class Solution {
public:
    int getMaxProfit(vector<int>& inventory, int orders) {
        long long left = 1, right = *max_element(inventory.begin(), inventory.end());
        long long mod = 1e9 + 7;

        while (left < right) {
            long long mid = left + (right - left + 1) / 2;
            long long totalOrders = 0;

            for (int count : inventory) {
                totalOrders += max(0LL, count - mid);
            }

            if (totalOrders < orders) {
                right = mid - 1;
            } else {
                left = mid;
            }
        }

        long long totalProfit = 0;
        for (int count : inventory) {
            totalProfit += (count + 1) * count / 2;
        }
        totalProfit -= (left * (left - 1) / 2) * orders;

        return totalProfit % mod;
    }
};