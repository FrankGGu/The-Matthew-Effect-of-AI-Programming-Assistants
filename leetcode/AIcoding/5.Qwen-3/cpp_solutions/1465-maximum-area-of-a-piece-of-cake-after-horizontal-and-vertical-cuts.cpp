#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int maxArea(int h, int w, vector<int>& horizontalCuts, vector<int>& verticalCuts) {
        sort(horizontalCuts.begin(), horizontalCuts.end());
        sort(verticalCuts.begin(), verticalCuts.end());

        int maxH = 0;
        int prev = 0;
        for (int cut : horizontalCuts) {
            maxH = max(maxH, cut - prev);
            prev = cut;
        }
        maxH = max(maxH, h - prev);

        int maxW = 0;
        prev = 0;
        for (int cut : verticalCuts) {
            maxW = max(maxW, cut - prev);
            prev = cut;
        }
        maxW = max(maxW, w - prev);

        return static_cast<long long>(maxH) * maxW;
    }
};