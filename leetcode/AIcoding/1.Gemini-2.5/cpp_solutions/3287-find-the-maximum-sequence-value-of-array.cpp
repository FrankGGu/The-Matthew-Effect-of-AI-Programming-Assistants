#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    long long maxScore(vector<int>& nums) {
        int n = nums.size();
        long long max_val = -1e18;
        for (int i = 0; i < (1 << n); ++i) {
            long long current_val = 0;
            vector<int> current_subset;
            for (int j = 0; j < n; ++j) {
                if ((i >> j) & 1) {
                    current_subset.push_back(nums[j]);
                }
            }
            if (current_subset.empty()) continue;

            long long product = 1;
            for (int num : current_subset) {
                product *= num;
            }
            current_val = product;
            max_val = max(max_val, current_val);
        }
        return max_val;
    }
};