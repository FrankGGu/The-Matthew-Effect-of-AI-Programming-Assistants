#include <vector>
#include <set>

class Solution {
public:
    int countDistinct(std::vector<int>& nums, int k, int p) {
        std::set<std::vector<int>> distinct_subarrays;
        int n = nums.size();

        for (int i = 0; i < n; ++i) {
            std::vector<int> current_subarray;
            int count = 0;
            for (int j = i; j < n; ++j) {
                current_subarray.push_back(nums[j]);
                if (nums[j] % p == 0) {
                    count++;
                }
                if (count <= k) {
                    distinct_subarrays.insert(current_subarray);
                } else {
                    break;
                }
            }
        }
        return distinct_subarrays.size();
    }
};