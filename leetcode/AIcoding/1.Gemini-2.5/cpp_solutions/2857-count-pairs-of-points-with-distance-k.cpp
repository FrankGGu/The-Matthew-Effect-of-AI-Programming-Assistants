#include <vector>
#include <unordered_map>

class Solution {
public:
    int countPairs(std::vector<std::vector<int>>& points, int k) {
        std::unordered_map<long long, int> counts;
        int ans = 0;

        for (const auto& p : points) {
            int x1 = p[0];
            int y1 = p[1];

            for (int x_xor_val = 0; x_xor_val <= k; ++x_xor_val) {
                int y_xor_val = k - x_xor_val;

                int x2 = x1 ^ x_xor_val;
                int y2 = y1 ^ y_xor_val;

                long long target_key = (static_cast<long long>(x2) << 21) | y2;
                if (counts.count(target_key)) {
                    ans += counts[target_key];
                }
            }

            long long current_key = (static_cast<long long>(x1) << 21) | y1;
            counts[current_key]++;
        }

        return ans;
    }
};