#include <vector>
#include <algorithm>
#include <numeric>

class Solution {
public:
    long long putMarbles(std::vector<int>& weights, int k) {
        int n = weights.size();

        if (k == 1 || k == n) {
            return 0;
        }

        std::vector<long long> pair_sums;
        pair_sums.reserve(n - 1);
        for (int i = 0; i < n - 1; ++i) {
            pair_sums.push_back(static_cast<long long>(weights[i]) + weights[i+1]);
        }

        std::sort(pair_sums.begin(), pair_sums.end());

        long long min_score_sum = 0;
        for (int i = 0; i < k - 1; ++i) {
            min_score_sum += pair_sums[i];
        }

        long long max_score_sum = 0;
        for (int i = 0; i < k - 1; ++i) {
            max_score_sum += pair_sums[n - 2 - i];
        }

        return max_score_sum - min_score_sum;
    }
};