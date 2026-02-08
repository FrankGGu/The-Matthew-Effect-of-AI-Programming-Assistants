#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    bool carPooling(vector<vector<int>>& trips, int capacity) {
        vector<int> timeline(1001, 0);
        for (const auto& trip : trips) {
            timeline[trip[1]] += trip[0];
            timeline[trip[2]] -= trip[0];
        }
        int currentPassengers = 0;
        for (int i = 0; i < 1001; ++i) {
            currentPassengers += timeline[i];
            if (currentPassengers > capacity) {
                return false;
            }
        }
        return true;
    }
};