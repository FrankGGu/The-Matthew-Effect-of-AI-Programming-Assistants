#include <vector>

class Solution {
public:
    std::vector<int> cycleLengthQueries(int n, std::vector<std::vector<int>>& queries) {
        std::vector<int> results;
        results.reserve(queries.size());

        for (const auto& query : queries) {
            int u = query[0];
            int v = query[1];

            int current_u = u;
            int current_v = v;

            int original_depth_u = 0;
            int temp_u_depth_calc = u;
            while (temp_u_depth_calc > 1) {
                temp_u_depth_calc /= 2;
                original_depth_u++;
            }

            int original_depth_v = 0;
            int temp_v_depth_calc = v;
            while (temp_v_depth_calc > 1) {
                temp_v_depth_calc /= 2;
                original_depth_v++;
            }

            int aligned_depth_u = original_depth_u;
            int aligned_depth_v = original_depth_v;

            while (aligned_depth_u > aligned_depth_v) {
                current_u /= 2;
                aligned_depth_u--;
            }
            while (aligned_depth_v > aligned_depth_u) {
                current_v /= 2;
                aligned_depth_v--;
            }

            while (current_u != current_v) {
                current_u /= 2;
                current_v /= 2;
            }
            int lca = current_u;

            int depth_lca = 0;
            int temp_lca_depth_calc = lca;
            while (temp_lca_depth_calc > 1) {
                temp_lca_depth_calc /= 2;
                depth_lca++;
            }

            results.push_back(original_depth_u + original_depth_v - 2 * depth_lca + 1);
        }

        return results;
    }
};