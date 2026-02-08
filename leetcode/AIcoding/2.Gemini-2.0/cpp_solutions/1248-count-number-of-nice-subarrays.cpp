#include <vector>

using namespace std;

class Solution {
public:
    int numberOfSubarrays(vector<int>& nums, int k) {
        int n = nums.size();
        vector<int> odd_indices;
        odd_indices.push_back(-1);
        for (int i = 0; i < n; ++i) {
            if (nums[i] % 2 != 0) {
                odd_indices.push_back(i);
            }
        }
        odd_indices.push_back(n);

        int count = 0;
        for (int i = 1; i + k < odd_indices.size(); ++i) {
            count += (odd_indices[i] - odd_indices[i - 1]) * (odd_indices[i + k] - odd_indices[i + k - 1]);
        }

        return count;
    }
};