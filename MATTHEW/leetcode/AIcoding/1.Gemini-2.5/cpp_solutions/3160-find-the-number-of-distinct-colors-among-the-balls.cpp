#include <vector>
#include <unordered_map>

class Solution {
public:
    std::vector<int> distinctColors(std::vector<int>& colors, std::vector<std::vector<int>>& queries) {
        std::unordered_map<int, int> color_counts;
        int distinct_count = 0;

        for (int color : colors) {
            if (color_counts[color] == 0) {
                distinct_count++;
            }
            color_counts[color]++;
        }

        std::vector<int> result;
        result.reserve(queries.size());

        for (const auto& query : queries) {
            int index = query[0];
            int new_color = query[1];

            int old_color = colors[index];

            color_counts[old_color]--;
            if (color_counts[old_color] == 0) {
                distinct_count--;
            }

            if (color_counts[new_color] == 0) {
                distinct_count++;
            }
            color_counts[new_color]++;

            colors[index] = new_color;

            result.push_back(distinct_count);
        }

        return result;
    }
};