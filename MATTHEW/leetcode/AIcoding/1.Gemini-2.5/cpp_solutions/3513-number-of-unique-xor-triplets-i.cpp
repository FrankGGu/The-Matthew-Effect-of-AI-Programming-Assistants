#include <vector>
#include <unordered_map>

class Solution {
public:
    int tripletCount(std::vector<int>& nums) {
        int n = nums.size();
        if (n < 3) {
            return 0;
        }
        int count = 0;
        for (int j = 1; j < n - 1; ++j) {
            std::unordered_map<int, int> left_counts;
            for (int i = 0; i < j; ++i) {
                left_counts[nums[i]]++;
            }

            for (int k = j + 1; k < n; ++k) {
                int target = nums[j] ^ nums[k];
                if (left_counts.count(target)) {
                    count += left_counts.at(target);
                }
            }
        }
        return count;
    }
};