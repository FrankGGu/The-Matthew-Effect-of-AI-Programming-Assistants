#include <vector>
#include <algorithm>
#include <numeric>

using namespace std;

class Solution {
public:
    vector<long long> minOperations(vector<int>& nums, vector<int>& queries) {
        sort(nums.begin(), nums.end());
        int n = nums.size();
        vector<long long> prefix(n + 1, 0);
        for (int i = 0; i < n; ++i) {
            prefix[i + 1] = prefix[i] + nums[i];
        }

        vector<long long> res;
        for (int q : queries) {
            auto it = upper_bound(nums.begin(), nums.end(), q);
            int k = it - nums.begin();
            long long left = (long long)q * k - prefix[k];
            long long right = (prefix[n] - prefix[k]) - (long long)q * (n - k);
            res.push_back(left + right);
        }
        return res;
    }
};