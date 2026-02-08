#include <vector>

class Solution {
public:
    std::vector<int> mostCompetitive(std::vector<int>& nums, int k) {
        std::vector<int> res;
        int n = nums.size();

        for (int i = 0; i < n; ++i) {
            while (!res.empty() && res.back() > nums[i] && (res.size() - 1 + (n - i) >= k)) {
                res.pop_back();
            }
            if (res.size() < k) {
                res.push_back(nums[i]);
            }
        }

        return res;
    }
};