#include <iostream>
#include <vector>
#include <climits>

using namespace std;

class Solution {
public:
    long long maximumTripletValue(vector<int>& nums) {
        int n = nums.size();
        long long result = 0;
        vector<long long> maxFromRight(n, 0);
        maxFromRight[n - 1] = INT_MIN;
        for (int i = n - 2; i >= 0; --i) {
            maxFromRight[i] = max(maxFromRight[i + 1], static_cast<long long>(nums[i + 1]));
        }
        for (int i = 0; i < n - 2; ++i) {
            if (nums[i] > 0) {
                for (int j = i + 1; j < n - 1; ++j) {
                    if (nums[j] > 0 && maxFromRight[j] > 0) {
                        result = max(result, static_cast<long long>(nums[i]) * nums[j] * maxFromRight[j]);
                    }
                }
            }
        }
        return result;
    }
};