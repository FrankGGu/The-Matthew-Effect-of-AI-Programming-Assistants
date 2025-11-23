#include <vector>
#include <string>
#include <unordered_map>

class Solution {
public:
    long long concatenatedDivisibility(std::vector<int>& nums, int k) {
        std::vector<std::unordered_map<int, int>> len_counts(11);
        for (int num : nums) {
            int len = std::to_string(num).length();
            len_counts[len][num % k]++;
        }

        std::vector<long long> pow10(11);
        pow10[0] = 1;
        for (int i = 1; i <= 10; ++i) {
            pow10[i] = (pow10[i - 1] * 10) % k;
        }

        long long ans = 0;
        for (int num : nums) {
            long long rem = num % k;
            int len = std::to_string(num).length();

            for (int j_len = 1; j_len <= 10; ++j_len) {
                if (len_counts[j_len].empty()) {
                    continue;
                }
                long long required_rem = (k - (rem * pow10[j_len]) % k) % k;
                if (len_counts[j_len].count(required_rem)) {
                    ans += len_counts[j_len].at(required_rem);
                }
            }

            long long self_concat_rem = (rem * pow10[len] + rem) % k;
            if (self_concat_rem == 0) {
                ans--;
            }
        }

        return ans;
    }
};