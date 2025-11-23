#include <vector>
#include <unordered_map>
#include <algorithm> // For std::max

class Solution {
public:
    long long power(long long base, long long exp) {
        long long res = 1;
        long long MOD = 1e9 + 7;
        base %= MOD;
        while (exp > 0) {
            if (exp % 2 == 1) {
                res = (res * base) % MOD;
            }
            base = (base * base) % MOD;
            exp /= 2;
        }
        return res;
    }

    int numberOfGoodPartitions(std::vector<int>& nums) {
        std::unordered_map<int, int> last_occurrence;
        int n = nums.size();

        for (int i = 0; i < n; ++i) {
            last_occurrence[nums[i]] = i;
        }

        int num_cut_points = 0;
        int current_max_reach = 0;

        for (int i = 0; i < n; ++i) {
            current_max_reach = std::max(current_max_reach, last_occurrence[nums[i]]);

            if (i == current_max_reach) {
                num_cut_points++;
            }
        }

        return power(2, num_cut_points - 1);
    }
};