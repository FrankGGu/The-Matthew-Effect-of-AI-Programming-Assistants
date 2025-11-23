#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int minTaps(int n, vector<int>& ranges) {
        vector<int> maxReach(n + 1, 0);
        for (int i = 0; i <= n; ++i) {
            int start = max(0, i - ranges[i]);
            int end = min(n, i + ranges[i]);
            maxReach[start] = max(maxReach[start], end);
        }

        int taps = 0;
        int currentReach = 0;
        int nextReach = 0;

        for (int i = 0; i < n; ++i) {
            nextReach = max(nextReach, maxReach[i]);
            if (i == currentReach) {
                if (currentReach == nextReach) {
                    return -1;
                }
                taps++;
                currentReach = nextReach;
            }
        }

        return taps;
    }
};