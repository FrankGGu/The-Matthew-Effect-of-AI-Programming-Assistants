#include <vector>
#include <numeric>
#include <map>

class Solution {
public:
    long long countPairs(std::vector<int>& nums, int k) {
        long long ans = 0;
        std::map<int, int> gcd_counts;

        for (int num : nums) {
            int current_gcd = std::gcd(num, k);
            for (auto const& [prev_gcd, count] : gcd_counts) {
                if ((long long)current_gcd * prev_gcd % k == 0) {
                    ans += count;
                }
            }
            gcd_counts[current_gcd]++;
        }

        return ans;
    }
};