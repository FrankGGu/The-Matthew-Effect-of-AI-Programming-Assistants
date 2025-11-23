#include <vector>
#include <algorithm>
#include <climits>

using namespace std;

class Solution {
public:
    int minCost(int n, int m, vector<int>& horizontalCuts, vector<int>& verticalCuts) {
        sort(horizontalCuts.begin(), horizontalCuts.end());
        sort(verticalCuts.begin(), verticalCuts.end());

        int maxH = max(horizontalCuts[0], n - horizontalCuts.back());
        for (int i = 1; i < horizontalCuts.size(); ++i) {
            maxH = max(maxH, horizontalCuts[i] - horizontalCuts[i-1]);
        }

        int maxV = max(verticalCuts[0], m - verticalCuts.back());
        for (int i = 1; i < verticalCuts.size(); ++i) {
            maxV = max(maxV, verticalCuts[i] - verticalCuts[i-1]);
        }

        return (long long)maxH * maxV % 1000000007;
    }
};