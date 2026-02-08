#include <vector>
#include <algorithm>
#include <cmath>

using namespace std;

class Solution {
public:
    int totalManhattanDistance(vector<vector<int>>& positions) {
        int n = positions.size();
        if (n < 2) return 0;

        int total = 0;
        for (int i = 0; i < n; ++i) {
            for (int j = i + 1; j < n; ++j) {
                total += abs(positions[i][0] - positions[j][0]) + abs(positions[i][1] - positions[j][1]);
            }
        }
        return total;
    }
};