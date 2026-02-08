#include <vector>
#include <numeric>
#include <algorithm>

class Solution {
public:
    std::vector<int> findKDistantIndices(std::vector<int>& nums, int key, int k) {
        int n = nums.size();
        std::vector<bool> is_k_distant(n, false);

        for (int i = 0; i < n; ++i) {
            if (nums[i] == key) {
                int start_j = std::max(0, i - k);
                int end_j = std::min(n - 1, i + k);
                for (int j = start_j; j <= end_j; ++j) {
                    is_k_distant[j] = true;
                }
            }
        }

        std::vector<int> result;
        for (int j = 0; j < n; ++j) {
            if (is_k_distant[j]) {
                result.push_back(j);
            }
        }

        return result;
    }
};