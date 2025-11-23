#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    long long sumX(vector<int>& nums, int k) {
        long long total = 0;
        int n = nums.size();
        for (int i = 0; i <= n - k; ++i) {
            int max_val = *max_element(nums.begin() + i, nums.begin() + i + k);
            total += max_val;
        }
        return total;
    }
};