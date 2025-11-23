#include <iostream>
#include <vector>
#include <algorithm>
#include <map>

using namespace std;

class Solution {
public:
    vector<int> corpFlightBookings(vector<vector<int>>& bookings, int n) {
        vector<int> res(n, 0);
        for (const auto& b : bookings) {
            int l = b[0] - 1;
            int r = b[1] - 1;
            int cnt = b[2];
            res[l] += cnt;
            if (r + 1 < n) {
                res[r + 1] -= cnt;
            }
        }
        for (int i = 1; i < n; ++i) {
            res[i] += res[i - 1];
        }
        return res;
    }
};