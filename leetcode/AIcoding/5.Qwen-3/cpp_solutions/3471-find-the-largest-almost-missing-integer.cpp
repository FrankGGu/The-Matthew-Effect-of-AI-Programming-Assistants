#include <iostream>
#include <vector>
#include <unordered_set>
#include <climits>

using namespace std;

class Solution {
public:
    int findLargestAlmostMissingInteger(vector<int>& nums) {
        unordered_set<int> uniqueNums(nums.begin(), nums.end());
        int maxVal = INT_MIN;
        for (int num : uniqueNums) {
            if (uniqueNums.find(num + 1) == uniqueNums.end()) {
                maxVal = max(maxVal, num);
            }
        }
        return maxVal;
    }
};