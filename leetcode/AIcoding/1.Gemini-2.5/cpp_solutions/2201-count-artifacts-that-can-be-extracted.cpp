#include <vector>

class Solution {
public:
    int countArtifacts(int n, std::vector<std::vector<int>>& artifacts, std::vector<std::vector<int>>& dig) {
        std::vector<std::vector<bool>> dug_grid(n, std::vector<bool>(n, false));

        for (const auto& d : dig) {
            dug_grid[d[0]][d[1]] = true;
        }

        int extracted_artifacts_count = 0;

        for (const auto& artifact : artifacts) {
            int r1 = artifact[0];
            int c1 = artifact[1];
            int r2 = artifact[2];
            int c2 = artifact[3];

            bool can_extract_current_artifact = true;

            for (int r = r1; r <= r2; ++r) {
                for (int c = c1; c <= c2; ++c) {
                    if (!dug_grid[r][c]) {
                        can_extract_current_artifact = false;
                        break;
                    }
                }
                if (!can_extract_current_artifact) {
                    break;
                }
            }

            if (can_extract_current_artifact) {
                extracted_artifacts_count++;
            }
        }

        return extracted_artifacts_count;
    }
};