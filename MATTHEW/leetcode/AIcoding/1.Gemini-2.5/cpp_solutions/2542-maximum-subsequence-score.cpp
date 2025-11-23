#include <vector>
#include <algorithm>
#include <queue>

class Solution {
public:
    long long maxScore(std::vector<int>& nums, std::vector<int>& multipliers, int k) {
        int n = nums.size();
        std::vector<std::pair<int, int>> pairs(n);
        for (int i = 0; i < n; ++i) {
            pairs[i] = {multipliers[i], nums[i]};
        }

        std::sort(pairs.begin(), pairs.end(), [](const std::pair<int, int>& a, const std::pair<int, int>& b) {
            return a.first > b.first;
        });

        long long max_score = 0;
        long long current_sum_nums = 0;
        std::priority_queue<int, std::vector<int>, std::greater<int>> min_pq; // Min-priority queue to keep track of k largest nums

        for (int i = 0; i < n; ++i) {
            int current_multiplier = pairs[i].first;
            int current_num = pairs[i].second;

            current_sum_nums += current_num;
            min_pq.push(current_num);

            if (min_pq.size() > k) {
                current_sum_nums -= min_pq.top();
                min_pq.pop();
            }

            if (min_pq.size() == k) {
                max_score = std::max(max_score, current_sum_nums * current_multiplier);
            }
        }

        return max_score;
    }
};