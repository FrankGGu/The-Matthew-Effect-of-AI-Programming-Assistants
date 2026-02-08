#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    long long maximumTripletValue(vector<int>& nums) {
        long long max_val = 0;
        int n = nums.size();
        for (int i = 0; i < n; ++i) {
            for (int j = i + 1; j < n; ++j) {
                for (int k = j + 1; k < n; ++k) {
                    max_val = max(max_val, (long long)(nums[i] - nums[j]) * nums[k]);
                }
            }
        }
        return max_val;
    }
};