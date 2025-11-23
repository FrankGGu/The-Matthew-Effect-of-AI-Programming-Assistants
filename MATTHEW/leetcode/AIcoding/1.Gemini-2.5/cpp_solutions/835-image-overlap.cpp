#include <vector>
#include <map>
#include <algorithm>

class Solution {
public:
    int largestOverlap(std::vector<std::vector<int>>& img1, std::vector<std::vector<int>>& img2) {
        int n = img1.size();
        std::vector<std::pair<int, int>> ones_img1;
        std::vector<std::pair<int, int>> ones_img2;

        for (int r = 0; r < n; ++r) {
            for (int c = 0; c < n; ++c) {
                if (img1[r][c] == 1) {
                    ones_img1.push_back({r, c});
                }
                if (img2[r][c] == 1) {
                    ones_img2.push_back({r, c});
                }
            }
        }

        std::map<std::pair<int, int>, int> translation_counts;
        int max_overlap = 0;

        for (const auto& p1 : ones_img1) {
            for (const auto& p2 : ones_img2) {
                // Calculate the required translation (dr, dc)
                // such that img2's '1' at p2 aligns with img1's '1' at p1.
                // If img2 is shifted by (dr, dc), then a point (r_img2, c_img2)
                // in img2 moves to (r_img2 + dr, c_img2 + dc) in the combined grid.
                // We want (p2.first + dr, p2.second + dc) == (p1.first, p1.second)
                // So, dr = p1.first - p2.first
                // and dc = p1.second - p2.second
                int dr = p1.first - p2.first;
                int dc = p1.second - p2.second;
                translation_counts[{dr, dc}]++;
                max_overlap = std::max(max_overlap, translation_counts[{dr, dc}]);
            }
        }

        return max_overlap;
    }
};