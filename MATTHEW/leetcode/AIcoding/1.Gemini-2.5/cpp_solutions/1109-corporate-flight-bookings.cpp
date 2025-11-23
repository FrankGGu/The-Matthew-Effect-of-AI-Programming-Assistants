class Solution {
public:
    std::vector<int> corpFlightBookings(std::vector<std::vector<int>>& bookings, int n) {
        std::vector<int> ans(n, 0);

        for (const auto& booking : bookings) {
            int firstFlight = booking[0];
            int lastFlight = booking[1];
            int seats = booking[2];

            ans[firstFlight - 1] += seats;
            if (lastFlight < n) {
                ans[lastFlight] -= seats;
            }
        }

        for (int i = 1; i < n; ++i) {
            ans[i] += ans[i - 1];
        }

        return ans;
    }
};