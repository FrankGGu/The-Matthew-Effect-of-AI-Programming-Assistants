#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int maximumBags(int capacity[], int n, int rocks[], int additionalRocks) {
        vector<int> diff(n);
        for (int i = 0; i < n; ++i) {
            diff[i] = capacity[i] - rocks[i];
        }
        sort(diff.begin(), diff.end());
        int count = 0;
        for (int i = 0; i < n && additionalRocks > 0; ++i) {
            if (diff[i] <= 0) {
                ++count;
            } else if (additionalRocks >= diff[i]) {
                additionalRocks -= diff[i];
                ++count;
            }
        }
        return count;
    }
};