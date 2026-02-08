#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    long long maximumArea(int h, int w, vector<vector<int>>& horizontalCuts, vector<vector<int>>& verticalCuts) {
        horizontalCuts.push_back({0});
        horizontalCuts.push_back({h});
        verticalCuts.push_back({0});
        verticalCuts.push_back({w});

        sort(horizontalCuts.begin(), horizontalCuts.end());
        sort(verticalCuts.begin(), verticalCuts.end());

        long long maxH = 0;
        for (size_t i = 1; i < horizontalCuts.size(); ++i) {
            maxH = max(maxH, (long long)(horizontalCuts[i][0] - horizontalCuts[i - 1][0]));
        }

        long long maxW = 0;
        for (size_t i = 1; i < verticalCuts.size(); ++i) {
            maxW = max(maxW, (long long)(verticalCuts[i][0] - verticalCuts[i - 1][0]));
        }

        long long mod = 1e9 + 7;
        return (maxH * maxW) % mod;
    }
};