#include <vector>
#include <set>

using namespace std;

class Solution {
public:
    int countLatticePoints(vector<vector<int>>& circles) {
        set<pair<int, int>> latticePoints;

        for (auto& circle : circles) {
            int x = circle[0];
            int y = circle[1];
            int r = circle[2];

            for (int i = x - r; i <= x + r; ++i) {
                for (int j = y - r; j <= y + r; ++j) {
                    if ((i - x) * (i - x) + (j - y) * (j - y) <= r * r) {
                        latticePoints.insert({i, j});
                    }
                }
            }
        }

        return latticePoints.size();
    }
};