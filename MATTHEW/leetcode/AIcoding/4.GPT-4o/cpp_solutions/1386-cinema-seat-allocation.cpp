class Solution {
public:
    int maxProfit(int n, vector<vector<int>>& bookings) {
        vector<int> seats(1001, 0);
        for (const auto& booking : bookings) {
            seats[booking[1]] += booking[2];
            if (booking[0] < 1000) seats[booking[0] + 1] -= booking[2];
        }
        int maxProfit = 0, currentProfit = 0;
        for (int i = 1; i <= n; ++i) {
            currentProfit += seats[i];
            maxProfit = max(maxProfit, currentProfit);
        }
        return maxProfit;
    }
};