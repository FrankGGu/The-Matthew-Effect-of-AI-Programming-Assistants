#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int numberOfArrays(int n, vector<int>& differences, int lower, int upper) {
        long long minVal = 0, maxVal = 0, current = 0;
        for (int diff : differences) {
            current += diff;
            minVal = min(minVal, current);
            maxVal = max(maxVal, current);
        }

        long long range = (long long)upper - lower;
        long long diffRange = maxVal - minVal;

        if (diffRange > range - (n - 1)) {
            return 0;
        }

        return max((long long)0, range - diffRange - (n - 1) + 1);
    }
};