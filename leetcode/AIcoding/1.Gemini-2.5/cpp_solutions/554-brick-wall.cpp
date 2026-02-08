#include <vector>
#include <unordered_map>
#include <algorithm>

class Solution {
public:
    int leastBricks(std::vector<std::vector<int>>& wall) {
        std::unordered_map<long long, int> edge_counts;
        int max_edges = 0;
        int num_rows = wall.size();

        for (const auto& row : wall) {
            long long current_pos = 0;
            for (size_t i = 0; i < row.size() - 1; ++i) {
                current_pos += row[i];
                edge_counts[current_pos]++;
                if (edge_counts[current_pos] > max_edges) {
                    max_edges = edge_counts[current_pos];
                }
            }
        }

        return num_rows - max_edges;
    }
};