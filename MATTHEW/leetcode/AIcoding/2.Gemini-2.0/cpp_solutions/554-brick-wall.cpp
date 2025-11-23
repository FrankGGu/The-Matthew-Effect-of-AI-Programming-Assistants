#include <vector>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int leastBricks(vector<vector<int>>& wall) {
        unordered_map<int, int> counts;
        int max_count = 0;
        for (auto& row : wall) {
            int width = 0;
            for (int i = 0; i < row.size() - 1; ++i) {
                width += row[i];
                counts[width]++;
                max_count = max(max_count, counts[width]);
            }
        }
        return wall.size() - max_count;
    }
};