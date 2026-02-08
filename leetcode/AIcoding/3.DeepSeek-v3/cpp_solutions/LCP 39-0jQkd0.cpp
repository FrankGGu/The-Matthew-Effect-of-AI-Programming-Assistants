#include <vector>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int minimumSwitchingTimes(vector<vector<int>>& source, vector<vector<int>>& target) {
        unordered_map<int, int> count;
        for (const auto& row : source) {
            for (int color : row) {
                count[color]++;
            }
        }
        for (const auto& row : target) {
            for (int color : row) {
                count[color]--;
            }
        }
        int res = 0;
        for (const auto& pair : count) {
            if (pair.second > 0) {
                res += pair.second;
            }
        }
        return res;
    }
};