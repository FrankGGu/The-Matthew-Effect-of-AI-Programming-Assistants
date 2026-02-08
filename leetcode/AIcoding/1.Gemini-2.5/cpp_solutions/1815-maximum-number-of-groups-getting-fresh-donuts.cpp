#include <iostream>
#include <vector>
#include <numeric>
#include <map>
#include <algorithm>

class Solution {
public:
    int batchSize;
    std::map<std::vector<int>, std::vector<int>> memo;

    int solve(std::vector<int> counts, int rem) {
        bool all_zero = true;
        for (int c : counts) {
            if (c > 0) {
                all_zero = false;
                break;
            }
        }
        if (all_zero) {
            return 0;
        }

        if (memo.count(counts) && memo[counts][rem] != -1) {
            return memo[counts][rem];
        }

        int happy_gain = (rem == 0) ? 1 : 0;
        int max_val = 0;

        for (size_t i = 0; i < counts.size(); ++i) {
            if (counts[i] > 0) {
                counts[i]--;
                max_val = std::max(max_val, happy_gain + solve(counts, (rem + i + 1) % batchSize));
                counts[i]++;
            }
        }

        if (!memo.count(counts)) {
            memo[counts] = std::vector<int>(batchSize, -1);
        }
        return memo[counts][rem] = max_val;
    }

    int maxHappyGroups(int batchSize, std::vector<int>& groups) {
        this->batchSize = batchSize;
        std::vector<int> initial_counts(batchSize, 0);
        for (int g : groups) {
            initial_counts[g % batchSize]++;
        }

        int ans = initial_counts[0];

        for (int i = 1; i <= batchSize / 2; ++i) {
            if (i * 2 == batchSize) {
                ans += initial_counts[i] / 2;
                initial_counts[i] %= 2;
            } else {
                int pairs = std::min(initial_counts[i], initial_counts[batchSize - i]);
                ans += pairs;
                initial_counts[i] -= pairs;
                initial_counts[batchSize - i] -= pairs;
            }
        }

        std::vector<int> rem_counts;
        int n_rem = 0;
        for(int i = 1; i < batchSize; ++i) {
            rem_counts.push_back(initial_counts[i]);
            n_rem += initial_counts[i];
        }

        if (n_rem == 0) {
            return ans;
        }

        memo.clear();
        int max_rem_happy = 0;
        for (size_t i = 0; i < rem_counts.size(); ++i) {
            if (rem_counts[i] > 0) {
                rem_counts[i]--;
                max_rem_happy = std::max(max_rem_happy, 1 + solve(rem_counts, (i + 1) % batchSize));
                rem_counts[i]++;
            }
        }

        return ans + max_rem_happy;
    }
};