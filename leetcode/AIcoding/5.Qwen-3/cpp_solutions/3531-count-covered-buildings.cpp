#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int countCoveredBuildings(vector<int>& heights) {
        int n = heights.size();
        vector<int> covered(n, 0);
        for (int i = 0; i < n; ++i) {
            int j = i + 1;
            while (j < n && heights[j] < heights[i]) {
                covered[j] = 1;
                ++j;
            }
        }
        int count = 0;
        for (int i = 0; i < n; ++i) {
            if (covered[i] == 0) {
                ++count;
            }
        }
        return count;
    }
};