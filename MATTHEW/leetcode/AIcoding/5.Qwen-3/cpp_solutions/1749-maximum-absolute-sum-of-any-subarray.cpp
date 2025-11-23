#include <iostream>
#include <vector>
#include <algorithm>
#include <climits>

using namespace std;

class Solution {
public:
    int maxAbsoluteSum(vector<int>& nums) {
        int maxEndingHere = 0;
        int maxSoFar = INT_MIN;
        int minEndingHere = 0;
        int minSoFar = INT_MAX;

        for (int num : nums) {
            maxEndingHere = max(num, maxEndingHere + num);
            maxSoFar = max(maxSoFar, maxEndingHere);

            minEndingHere = min(num, minEndingHere + num);
            minSoFar = min(minSoFar, minEndingHere);
        }

        return max(abs(maxSoFar), abs(minSoFar));
    }
};