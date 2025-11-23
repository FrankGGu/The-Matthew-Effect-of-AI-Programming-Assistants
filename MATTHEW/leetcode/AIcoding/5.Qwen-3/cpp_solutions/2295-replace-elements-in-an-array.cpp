#include <iostream>
#include <vector>

using namespace std;

class Solution {
public:
    vector<int> replaceElements(vector<int>& nums) {
        int maxVal = -1;
        for (int i = nums.size() - 1; i >= 0; --i) {
            int temp = nums[i];
            nums[i] = maxVal;
            maxVal = max(maxVal, temp);
        }
        return nums;
    }
};