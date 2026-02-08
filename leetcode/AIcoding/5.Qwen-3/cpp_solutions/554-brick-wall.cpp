#include <iostream>
#include <vector>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int leastBricks(vector<vector<int>>& wall) {
        unordered_map<int, int> count;
        int maxCount = 0;
        for (const auto& row : wall) {
            int pos = 0;
            for (int i = 0; i < row.size() - 1; ++i) {
                pos += row[i];
                count[pos]++;
                maxCount = max(maxCount, count[pos]);
            }
        }
        return wall.size() - maxCount;
    }
};