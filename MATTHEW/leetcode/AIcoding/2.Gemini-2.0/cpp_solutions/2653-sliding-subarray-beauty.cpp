#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    vector<int> getSubarrayBeauty(vector<int>& nums, int k, int x) {
        vector<int> result;
        for (int i = 0; i < nums.size() - k + 1; ++i) {
            vector<int> subarray;
            for (int j = i; j < i + k; ++j) {
                subarray.push_back(nums[j]);
            }
            sort(subarray.begin(), subarray.end());
            if (subarray[x - 1] < 0) {
                result.push_back(subarray[x - 1]);
            } else {
                result.push_back(0);
            }
        }
        return result;
    }
};