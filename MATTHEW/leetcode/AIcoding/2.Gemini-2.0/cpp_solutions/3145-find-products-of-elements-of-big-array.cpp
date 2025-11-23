#include <vector>

using namespace std;

class Solution {
public:
    vector<long long> productExceptSelf(vector<int>& nums) {
        int n = nums.size();
        vector<long long> result(n, 1);

        long long prefix = 1;
        for (int i = 0; i < n; ++i) {
            result[i] = prefix;
            prefix *= nums[i];
        }

        long long postfix = 1;
        for (int i = n - 1; i >= 0; --i) {
            result[i] *= postfix;
            postfix *= nums[i];
        }

        return result;
    }
};