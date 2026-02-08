#include <vector>
#include <string>
#include <algorithm>
#include <map>

class Solution {
public:
    std::vector<std::string> findRelativeRanks(std::vector<int>& score) {
        int n = score.size();
        std::vector<std::pair<int, int>> indexed_scores(n);
        for (int i = 0; i < n; ++i) {
            indexed_scores[i] = {score[i], i};
        }

        std::sort(indexed_scores.begin(), indexed_scores.end(), [](const std::pair<int, int>& a, const std::pair<int, int>& b) {
            return a.first > b.first;
        });

        std::vector<std::string> ranks(n);
        for (int i = 0; i < n; ++i) {
            int original_index = indexed_scores[i].second;
            if (i == 0) {
                ranks[original_index] = "Gold Medal";
            } else if (i == 1) {
                ranks[original_index] = "Silver Medal";
            } else if (i == 2) {
                ranks[original_index] = "Bronze Medal";
            } else {
                ranks[original_index] = std::to_string(i + 1);
            }
        }

        return ranks;
    }
};