#include <iostream>
#include <vector>
#include <climits>

using namespace std;

class Solution {
public:
    int maximumDifference(vector<int>& nums) {
        int minSoFar = INT_MAX;
        int maxDiff = -1;
        for (int num : nums) {
            if (num > minSoFar) {
                maxDiff = max(maxDiff, num - minSoFar);
            } else {
                minSoFar = num;
            }
        }
        return maxDiff;
    }
};