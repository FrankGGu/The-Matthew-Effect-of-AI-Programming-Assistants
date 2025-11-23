#include <vector>

using namespace std;

class Solution {
public:
    bool isCovered(vector<vector<int>>& ranges, int left, int right) {
        vector<bool> covered(right - left + 1, false);
        for (auto& range : ranges) {
            int start = range[0];
            int end = range[1];
            for (int i = left; i <= right; ++i) {
                if (i >= start && i <= end) {
                    covered[i - left] = true;
                }
            }
        }
        for (bool c : covered) {
            if (!c) {
                return false;
            }
        }
        return true;
    }
};