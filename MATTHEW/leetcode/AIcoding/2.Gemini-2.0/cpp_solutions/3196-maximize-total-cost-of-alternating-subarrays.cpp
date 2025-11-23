#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    long long maxAlternatingSum(vector<int>& nums) {
        long long even = nums[0];
        long long odd = 0;

        for (int i = 1; i < nums.size(); ++i) {
            long long new_even = max(even, odd + nums[i]);
            long long new_odd = max(odd, even - nums[i]);

            even = new_even;
            odd = new_odd;
        }

        return even;
    }
};