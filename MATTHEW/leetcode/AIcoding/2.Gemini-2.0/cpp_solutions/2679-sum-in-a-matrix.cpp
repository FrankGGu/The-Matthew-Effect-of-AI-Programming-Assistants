#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int matrixSum(vector<vector<int>>& nums) {
        int m = nums.size();
        int n = nums[0].size();
        int sum = 0;

        for (int i = 0; i < m; ++i) {
            sort(nums[i].begin(), nums[i].end());
        }

        for (int j = 0; j < n; ++j) {
            int max_val = 0;
            for (int i = 0; i < m; ++i) {
                max_val = max(max_val, nums[i][j]);
            }
            sum += max_val;
        }

        return sum;
    }
};