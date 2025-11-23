class Solution {
public:
    int maxProfit(vector<int>& inventory, int orders) {
        long long left = 1, right = *max_element(inventory.begin(), inventory.end()), mod = 1e9 + 7;
        long long res = 0;

        while (left <= right) {
            long long mid = left + (right - left) / 2;
            long long totalOrders = 0;

            for (int ball : inventory) {
                if (ball >= mid) {
                    totalOrders += ball - mid + 1;
                }
            }

            if (totalOrders >= orders) {
                res = (res + (mid % mod) * (totalOrders - orders + 1) % mod) % mod;
                right = mid - 1;
            } else {
                left = mid + 1;
            }
        }

        return res;
    }
};