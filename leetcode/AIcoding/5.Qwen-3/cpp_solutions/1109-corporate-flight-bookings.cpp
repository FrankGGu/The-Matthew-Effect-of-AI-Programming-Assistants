#include <iostream>
#include <vector>

using namespace std;

class Solution {
public:
    vector<int> corpFlightBookings(vector<vector<int>>& bookings, int n) {
        vector<int> res(n, 0);
        for (const auto& booking : bookings) {
            int start = booking[0] - 1;
            int end = booking[1] - 1;
            int seats = booking[2];
            res[start] += seats;
            if (end + 1 < n) {
                res[end + 1] -= seats;
            }
        }
        for (int i = 1; i < n; ++i) {
            res[i] += res[i - 1];
        }
        return res;
    }
};