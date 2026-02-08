#include <vector>
#include <numeric> // Not strictly needed for this solution, but common for vector operations

class Solution {
public:
    std::vector<int> findDiagonalOrder(std::vector<std::vector<int>>& mat) {
        if (mat.empty() || mat[0].empty()) {
            return {};
        }

        int m = mat.size();
        int n = mat[0].size();
        std::vector<int> result;
        result.reserve(m * n);

        int r = 0, c = 0;
        int direction = 1; // 1 for up-right, -1 for down-left

        for (int i = 0; i < m * n; ++i) {
            result.push_back(mat[r][c]);

            if (direction == 1) { // Moving up-right
                int next_r = r - 1;
                int next_c = c + 1;

                // Check for boundary hit
                if (next_r < 0 || next_c == n) {
                    // If hit right edge (or top-right corner)
                    if (next_c == n) {
                        r++; // Move down
                    } else { // If hit top edge (not top-right corner)
                        c++; // Move right
                    }
                    direction = -1; // Change direction to down-left
                } else { // No boundary hit, continue up-right
                    r = next_r;
                    c = next_c;
                }
            } else { // Moving down-left
                int next_r = r + 1;
                int next_c = c - 1;

                // Check for boundary hit
                if (next_r == m || next_c < 0) {
                    // If hit bottom edge (or bottom-left corner)
                    if (next_r == m) {
                        c++; // Move right
                    } else { // If hit left edge (not bottom-left corner)
                        r++; // Move down
                    }
                    direction = 1; // Change direction to up-right
                } else { // No boundary hit, continue down-left
                    r = next_r;
                    c = next_c;
                }
            }
        }

        return result;
    }
};