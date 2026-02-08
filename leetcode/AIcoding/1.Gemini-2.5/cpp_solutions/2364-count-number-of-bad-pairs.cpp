#include <vector>
#include <unordered_map>

class Solution {
public:
    long long countBadPairs(std::vector<int>& nums) {
        long long n = nums.size();
        if (n <= 1) {
            return 0;
        }

        long long good_pairs = 0;
        std::unordered_map<int, int> diff_counts;

        for (int i = 0; i < n; ++i) {
            int diff = nums[i] - i;
            good_pairs += diff_counts[diff];
            diff_counts[diff]++;
        }

        long long total_pairs = n * (n - 1) / 2;
        return total_pairs - good_pairs;
    }
};