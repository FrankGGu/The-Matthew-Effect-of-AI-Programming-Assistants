#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    bool carPooling(vector<vector<int>>& trips, int capacity) {
        vector<int> stops(1001, 0);
        for (auto& trip : trips) {
            stops[trip[1]] += trip[0];
            stops[trip[2]] -= trip[0];
        }
        int current = 0;
        for (int i = 0; i <= 1000; ++i) {
            current += stops[i];
            if (current > capacity) {
                return false;
            }
        }
        return true;
    }
};