#include <vector>
#include <map>
#include <algorithm>

class Solution {
public:
    long long maximumTotalDamage(std::vector<int>& damage) {
        std::map<long long, long long> counts;
        for (int d : damage) {
            counts[d] += d;
        }

        std::vector<long long> distinct_damages;
        for (auto const& [val, total_dmg] : counts) {
            distinct_damages.push_back(val);
        }

        if (distinct_damages.empty()) {
            return 0;
        }

        long long prev2 = 0; 
        long long prev1 = 0; 

        prev1 = counts[distinct_damages[0]];

        for (size_t i = 1; i < distinct_damages.size(); ++i) {
            long long current_val = distinct_damages[i];
            long long current_total_damage = counts[current_val];

            long long current_dp;

            if (current_val == distinct_damages[i-1] + 1) {
                current_dp = std::max(prev1, current_total_damage + prev2);
            } else {
                current_dp = prev1 + current_total_damage;
            }

            prev2 = prev1;
            prev1 = current_dp;
        }

        return prev1;
    }
};