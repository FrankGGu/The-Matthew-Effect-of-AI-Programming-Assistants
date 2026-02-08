#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int maximizeActiveSection(vector<int>& start, vector<int>& end) {
        sort(start.begin(), start.end());
        sort(end.begin(), end.end());

        int i = 0, j = 0, count = 0, maxCount = 0;
        while (i < start.size() && j < end.size()) {
            if (start[i] <= end[j]) {
                count++;
                i++;
            } else {
                count--;
                j++;
            }
            maxCount = max(maxCount, count);
        }

        return maxCount;
    }
};