#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    vector<pair<int, int>> bookings;

    bool book(int start, int end) {
        for (auto& booking : bookings) {
            if (max(start, booking.first) < min(end, booking.second)) {
                return false;
            }
        }
        bookings.push_back({start, end});
        return true;
    }
};