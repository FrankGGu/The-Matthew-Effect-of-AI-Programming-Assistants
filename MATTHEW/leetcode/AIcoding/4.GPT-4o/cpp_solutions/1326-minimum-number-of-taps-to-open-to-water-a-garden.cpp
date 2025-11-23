#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int minTaps(int n, vector<int>& ranges) {
        vector<int> maxRange(n + 1, 0);
        for (int i = 0; i <= n; ++i) {
            int left = max(0, i - ranges[i]);
            int right = min(n, i + ranges[i]);
            maxRange[left] = max(maxRange[left], right);
        }

        int taps = 0, currentEnd = 0, farthest = 0;
        for (int i = 0; i < n; ++i) {
            farthest = max(farthest, maxRange[i]);
            if (i == currentEnd) {
                taps++;
                currentEnd = farthest;
            }
            if (currentEnd >= n) break;
        }

        return currentEnd >= n ? taps : -1;
    }
};