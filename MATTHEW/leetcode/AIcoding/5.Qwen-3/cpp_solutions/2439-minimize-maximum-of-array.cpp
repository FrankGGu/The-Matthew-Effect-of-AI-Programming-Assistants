#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int minimizeArrayValue(vector<int>& nums) {
        long long sum = 0;
        int result = 0;
        for (int i = 0; i < nums.size(); ++i) {
            sum += nums[i];
            result = max(result, (int)((sum + i) / (i + 1)));
        }
        return result;
    }
};