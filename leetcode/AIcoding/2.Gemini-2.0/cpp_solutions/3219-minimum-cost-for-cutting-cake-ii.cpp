#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int minCost(int n, vector<int>& horizontalCuts, vector<int>& verticalCuts) {
        horizontalCuts.push_back(0);
        horizontalCuts.push_back(n);
        verticalCuts.push_back(0);
        verticalCuts.push_back(n);

        sort(horizontalCuts.begin(), horizontalCuts.end());
        sort(verticalCuts.begin(), verticalCuts.end());

        long long max_h = 0;
        for (int i = 1; i < horizontalCuts.size(); ++i) {
            max_h = max(max_h, (long long)(horizontalCuts[i] - horizontalCuts[i - 1]));
        }

        long long max_v = 0;
        for (int i = 1; i < verticalCuts.size(); ++i) {
            max_v = max(max_v, (long long)(verticalCuts[i] - verticalCuts[i - 1]));
        }

        long long mod = 1e9 + 7;
        return (max_h * max_v) % mod;
    }
};