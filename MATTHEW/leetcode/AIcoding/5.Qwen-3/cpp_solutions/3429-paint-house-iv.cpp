#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int minCostII(vector<int>& costs, int k) {
        int n = costs.size();
        if (n == 0 || k == 0) return 0;

        vector<int> prevCosts(k, 0);

        for (int i = 0; i < n; ++i) {
            vector<int> currCosts(k, 0);
            int min1 = INT_MAX, min2 = INT_MAX;
            int idx1 = -1;

            for (int j = 0; j < k; ++j) {
                if (prevCosts[j] < min1) {
                    min2 = min1;
                    min1 = prevCosts[j];
                    idx1 = j;
                } else if (prevCosts[j] < min2) {
                    min2 = prevCosts[j];
                }
            }

            for (int j = 0; j < k; ++j) {
                if (j != idx1) {
                    currCosts[j] = min1 + costs[i];
                } else {
                    currCosts[j] = min2 + costs[i];
                }
            }

            prevCosts = currCosts;
        }

        return *min_element(prevCosts.begin(), prevCosts.end());
    }
};