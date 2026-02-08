#include <vector>
#include <algorithm>
#include <numeric>

using namespace std;

class Solution {
public:
    vector<int> maxSubsequence(vector<int>& nums, int k) {
        int n = nums.size();
        vector<int> indices(n);
        iota(indices.begin(), indices.end(), 0);

        nth_element(indices.begin(), indices.begin() + k, indices.end(),
                      [&](int i, int j) { return nums[i] > nums[j]; });

        indices.resize(k);
        sort(indices.begin(), indices.end());

        vector<int> result;
        for (int i : indices) {
            result.push_back(nums[i]);
        }

        return result;
    }
};