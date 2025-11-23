#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int countWays(vector<vector<int>>& ranges) {
        sort(ranges.begin(), ranges.end());
        int n = ranges.size();
        long long result = 1;
        int prevEnd = -1;
        for (int i = 0; i < n; ++i) {
            if (ranges[i][0] > prevEnd) {
                result = (result * 2) % 1000000007;
                prevEnd = ranges[i][1];
            }
        }
        return static_cast<int>(result);
    }
};