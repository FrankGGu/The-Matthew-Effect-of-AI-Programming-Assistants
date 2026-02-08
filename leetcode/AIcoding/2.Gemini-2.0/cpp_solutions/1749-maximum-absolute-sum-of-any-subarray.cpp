#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int maxAbsoluteSum(vector<int>& nums) {
        int maxSoFar = 0;
        int minSoFar = 0;
        int currentMax = 0;
        int currentMin = 0;

        for (int num : nums) {
            currentMax = max(num, currentMax + num);
            maxSoFar = max(maxSoFar, currentMax);

            currentMin = min(num, currentMin + num);
            minSoFar = min(minSoFar, currentMin);
        }

        return max(abs(maxSoFar), abs(minSoFar));
    }
};