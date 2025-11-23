#include <vector>
#include <algorithm>
using namespace std;

class Solution {
public:
    long long maximumSumOfHeights(vector<int>& maxHeights) {
        int n = maxHeights.size();
        long long res = 0;

        for (int i = 0; i < n; ++i) {
            long long sum = maxHeights[i];
            int prev = maxHeights[i];

            for (int j = i - 1; j >= 0; --j) {
                prev = min(prev, maxHeights[j]);
                sum += prev;
            }

            prev = maxHeights[i];
            for (int j = i + 1; j < n; ++j) {
                prev = min(prev, maxHeights[j]);
                sum += prev;
            }

            res = max(res, sum);
        }

        return res;
    }
};