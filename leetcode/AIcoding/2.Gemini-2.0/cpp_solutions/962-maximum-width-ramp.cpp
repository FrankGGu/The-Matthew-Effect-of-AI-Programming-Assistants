#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int maxWidthRamp(vector<int>& nums) {
        int n = nums.size();
        vector<int> indices(n);
        for (int i = 0; i < n; ++i) {
            indices[i] = i;
        }

        sort(indices.begin(), indices.end(), [&](int i, int j) {
            return nums[i] < nums[j];
        });

        int min_index = n;
        int max_width = 0;

        for (int i = 0; i < n; ++i) {
            min_index = min(min_index, indices[i]);
            max_width = max(max_width, indices[i] - min_index);
        }

        return max_width;
    }
};