#include <vector>
#include <unordered_map>
#include <algorithm>

class Solution {
public:
    int maximumFrequency(std::vector<int>& nums) {
        int n = nums.size();
        if (n == 0) {
            return 0;
        }

        std::unordered_map<int, std::vector<int>> positions;
        for (int i = 0; i < n; ++i) {
            positions[nums[i]].push_back(i);
        }

        int max_freq = 0;
        for (const auto& pair : positions) {
            const std::vector<int>& pos_v = pair.second;
            int k = pos_v.size();

            std::vector<long long> aug_pos;
            aug_pos.reserve(k + 2);
            aug_pos.push_back(-1);
            for (int pos : pos_v) {
                aug_pos.push_back(pos);
            }
            aug_pos.push_back(n);

            long long min_f = aug_pos[0] - 0;
            int max_gain = 0;

            for (size_t q = 1; q < aug_pos.size(); ++q) {
                long long f_q = aug_pos[q] - q;
                max_gain = std::max(max_gain, (int)(f_q - min_f));
                min_f = std::min(min_f, f_q);
            }

            max_freq = std::max(max_freq, k + max_gain);
        }

        return max_freq;
    }
};