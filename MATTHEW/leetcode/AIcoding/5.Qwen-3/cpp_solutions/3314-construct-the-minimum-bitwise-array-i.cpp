#include <iostream>
#include <vector>
#include <climits>

using namespace std;

class Solution {
public:
    vector<int> minBitwiseArray(vector<int>& nums) {
        int n = nums.size();
        vector<int> result(n);

        for (int i = 0; i < n; ++i) {
            int num = nums[i];
            int minVal = INT_MAX;
            for (int j = 0; j <= num; ++j) {
                if ((j | num) == num) {
                    minVal = min(minVal, j);
                }
            }
            result[i] = minVal;
        }

        return result;
    }
};