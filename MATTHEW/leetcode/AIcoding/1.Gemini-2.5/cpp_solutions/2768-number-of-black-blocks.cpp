#include <vector>
#include <unordered_map>

class Solution {
public:
    std::vector<long long> countBlackBlocks(int m, int n, std::vector<std::vector<int>>& coordinates) {
        std::unordered_map<long long, int> block_counts;

        for (const auto& coord : coordinates) {
            int r = coord[0];
            int c = coord[1];

            for (int dr = -1; dr <= 0; ++dr) {
                for (int dc = -1; dc <= 0; ++dc) {
                    int tr = r + dr;
                    int tc = c + dc;

                    if (tr >= 0 && tr < m - 1 && tc >= 0 && tc < n - 1) {
                        block_counts[(long long)tr * n + tc]++;
                    }
                }
            }
        }

        std::vector<long long> ans(5, 0);

        for (const auto& pair : block_counts) {
            ans[pair.second]++;
        }

        long long total_blocks = (long long)(m - 1) * (n - 1);
        ans[0] = total_blocks - block_counts.size();

        return ans;
    }
};