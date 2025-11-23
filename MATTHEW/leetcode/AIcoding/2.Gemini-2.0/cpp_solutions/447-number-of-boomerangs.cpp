#include <vector>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int numberOfBoomerangs(vector<vector<int>>& points) {
        int n = points.size();
        int count = 0;

        for (int i = 0; i < n; ++i) {
            unordered_map<long long, int> distMap;
            for (int j = 0; j < n; ++j) {
                if (i == j) continue;
                long long dx = points[i][0] - points[j][0];
                long long dy = points[i][1] - points[j][1];
                long long distSq = dx * dx + dy * dy;
                distMap[distSq]++;
            }

            for (auto const& [dist, freq] : distMap) {
                count += freq * (freq - 1);
            }
        }

        return count;
    }
};