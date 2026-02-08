#include <iostream>
#include <vector>

using namespace std;

class Solution {
private:
    vector<int> prefixSum;

public:
    Solution(vector<int>& nums) {
        prefixSum.resize(nums.size() + 1, 0);
        for (int i = 0; i < nums.size(); ++i) {
            prefixSum[i + 1] = prefixSum[i] + nums[i];
        }
    }

    int sumRange(int left, int right) {
        return prefixSum[right + 1] - prefixSum[left];
    }
};