#include <iostream>
#include <vector>

using namespace std;

class Solution {
public:
    vector<int> numberOfArithmeticSlices(vector<int>& nums) {
        int n = nums.size();
        vector<int> result;
        if (n < 3) return result;

        for (int i = 0; i < n - 2; ++i) {
            int diff = nums[i + 1] - nums[i];
            for (int j = i + 2; j < n; ++j) {
                if (nums[j] - nums[j - 1] == diff) {
                    result.push_back(i);
                    result.push_back(j);
                } else {
                    break;
                }
            }
        }
        return result;
    }
};