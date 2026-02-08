#include <vector>
#include <algorithm>

class Solution {
public:
    int kthSmallest(std::vector<std::vector<int>>& mat, int k) {
        std::vector<int> sums = {0};

        for (const auto& row : mat) {
            std::vector<int> next_sums;
            for (int current_sum : sums) {
                for (int val : row) {
                    next_sums.push_back(current_sum + val);
                }
            }
            std::sort(next_sums.begin(), next_sums.end());

            if (next_sums.size() > k) {
                next_sums.resize(k);
            }
            sums = next_sums;
        }

        return sums[k - 1];
    }
};