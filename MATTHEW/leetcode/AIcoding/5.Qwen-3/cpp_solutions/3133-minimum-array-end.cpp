#include <iostream>
#include <vector>

using namespace std;

class Solution {
public:
    long long minArrayEnd(vector<int>& nums) {
        long long result = 0;
        for (int i = 0; i < nums.size(); ++i) {
            result |= static_cast<long long>(nums[i]) << (i - 1);
        }
        return result;
    }
};