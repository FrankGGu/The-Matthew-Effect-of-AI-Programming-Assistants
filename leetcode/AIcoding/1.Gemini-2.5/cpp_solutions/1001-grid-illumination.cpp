#include <vector>
#include <unordered_map>
#include <set>
#include <utility> // For std::pair

class Solution {
public:
    std::vector<int> gridIllumination(int n, std::vector<std::vector<int>>& lamps, std::vector<std::vector<int>>& queries) {
        std::unordered_map<int, int> row_counts;
        std::unordered_map<int, int> col_counts;
        std::unordered_map<int, int> diag1_counts; // r - c
        std::unordered_map<int, int> diag2_counts; // r + c
        std::set<std::pair<int, int>> active_lamps;

        for (const auto& lamp : lamps) {
            int r = lamp[0];
            int c = lamp[1];
            if (active_lamps.find({r, c}) == active_lamps.end()) {
                active_lamps.insert({r, c});
                row_counts[r]++;
                col_counts[c]++;
                diag1_counts[r - c]++;
                diag2_counts[r + c]++;
            }
        }

        std::vector<int> results;
        for (const auto& query : queries) {
            int r_q = query[0];
            int c_q = query[1];

            bool illuminated = false;
            if (row_counts[r_q] > 0 || 
                col_counts[c_q] > 0 || 
                diag1_counts[r_q - c_q] > 0 || 
                diag2_counts[r_q + c_q] > 0) {
                illuminated = true;
            }
            results.push_back(illuminated ? 1 : 0);

            // Turn off lamps in the 3x3 square centered at (r_q, c_q)
            for (int dr = -1; dr <= 1; ++dr) {
                for (int dc = -1; dc <= 1; ++dc) {
                    int nr = r_q + dr;
                    int nc = c_q + dc;

                    // No need to check nr, nc against N bounds,
                    // as active_lamps only contains valid coordinates.
                    // If {nr, nc} is not in active_lamps, find() will return end().
                    if (active_lamps.find({nr, nc}) != active_lamps.end()) {
                        active_lamps.erase({nr, nc});
                        row_counts[nr]--;
                        col_counts[nc]--;
                        diag1_counts[nr - nc]--;
                        diag2_counts[nr + nc]--;
                    }
                }
            }
        }

        return results;
    }
};