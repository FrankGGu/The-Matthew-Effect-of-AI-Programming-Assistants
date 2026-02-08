#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    vector<int> findErrorNums(vector<int>& nums) {
        int n = nums.size();
        vector<int> result(2, 0);

        for (int i = 0; i < n; ++i) {
            int index = abs(nums[i]) - 1;
            if (nums[index] < 0) {
                result[0] = abs(nums[i]);
            } else {
                nums[index] *= -1;
            }
        }

        for (int i = 0; i < n; ++i) {
            if (nums[i] > 0) {
                result[1] = i + 1;
                break;
            }
        }

        return result;
    }
};