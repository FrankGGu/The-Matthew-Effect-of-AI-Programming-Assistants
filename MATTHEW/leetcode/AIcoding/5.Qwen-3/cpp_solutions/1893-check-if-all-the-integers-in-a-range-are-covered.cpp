#include <vector>

using namespace std;

class Solution {
public:
    bool isCovered(vector<vector<int>>& ranges, int left, int right) {
        vector<bool> covered(101, false);
        for (const auto& range : ranges) {
            int start = range[0];
            int end = range[1];
            for (int i = start; i <= end; ++i) {
                covered[i] = true;
            }
        }
        for (int i = left; i <= right; ++i) {
            if (!covered[i]) {
                return false;
            }
        }
        return true;
    }
};