#include <vector>
#include <algorithm>

class Solution {
public:
    std::vector<long long> minCost(std::vector<int>& costs) {
        int n = costs.size();
        if (n == 0) {
            return {};
        }

        std::vector<long long> answer(n);
        answer[0] = 0;

        if (n == 1) {
            return answer;
        }

        long long min_prev_jump_cost = (long long)answer[0] + costs[0];

        for (int i = 1; i < n; ++i) {
            answer[i] = min_prev_jump_cost;
            min_prev_jump_cost = std::min(min_prev_jump_cost, answer[i] + costs[i]);
        }

        return answer;
    }
};