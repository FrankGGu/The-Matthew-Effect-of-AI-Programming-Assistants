#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int countCoveredBuildings(vector<vector<int>>& ranges) {
        sort(ranges.begin(), ranges.end());
        int count = 0;
        int current_end = -1;
        for (auto& range : ranges) {
            int start = range[0];
            int end = range[1];
            if (start > current_end) {
                count++;
                current_end = end;
            } else {
                current_end = max(current_end, end);
            }
        }
        return count;
    }
};