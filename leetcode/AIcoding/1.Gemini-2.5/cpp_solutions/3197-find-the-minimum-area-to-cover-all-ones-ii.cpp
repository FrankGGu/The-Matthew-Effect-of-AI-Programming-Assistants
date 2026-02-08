#include <vector>
#include <algorithm>
#include <limits> // Required for std::numeric_limits

class Solution {
public:
    long long calculate_bbox_area(const std::vector<std::pair<int, int>>& ones,
                                  int min_r_limit, int max_r_limit,
                                  int min_c_limit, int max_c_limit) {
        int min_r_found = std::numeric_limits<int>::max();
        int max_r_found = std::numeric_limits<int>::min();
        int min_c_found = std::numeric_limits<int>::max();
        int max_c_found = std::numeric_limits<int>::min();
        bool found_one = false;

        for (const auto& p : ones) {
            int r = p.first;
            int c = p.second;
            if (r >= min_r_limit && r <= max_r_limit &&
                c >= min_c_limit && c <= max_c_limit) {
                found_one = true;
                min_r_found = std::min(min_r_found, r);
                max_r_found = std::max(max_r_found, r);
                min_c_found = std::min(min_c_found, c);
                max_c_found = std::max(max_c_found, c);
            }
        }

        if (!found_one) {
            return 0;
        } else {
            return (long long)(max_r_found - min_r_found + 1) * (max_c_found - min_c_found + 1);
        }
    }

    int minimumArea(std::vector<std::vector<int>>& grid) {
        int R = grid.size();
        int C = grid[0].size();

        std::vector<std::pair<int, int>> ones;
        for (int r = 0; r < R; ++r) {
            for (int c = 0; c < C; ++c) {
                if (grid[r][c] == 1) {
                    ones.push_back({r, c});
                }
            }
        }

        long long min_total_area = std::numeric_limits<long long>::max();

        // Case 1: Three horizontal strips
        // Rectangles: [0, r1-1]x[0, C-1], [r1, r2-1]x[0, C-1], [r2, R-1]x[0, C-1]
        for (int r1 = 1; r1 < R; ++r1) { 
            for (int r2 = r1 + 1; r2 < R; ++r2) { 
                long long area1 = calculate_bbox_area(ones, 0, r1 - 1, 0, C - 1);
                long long area2 = calculate_bbox_area(ones, r1, r2 - 1, 0, C - 1);
                long long area3 = calculate_bbox_area(ones, r2, R - 1, 0, C - 1);
                min_total_area = std::min(min_total_area, area1 + area2 + area3);
            }
        }

        // Case 2: Three vertical strips
        // Rectangles: [0, R-1]x[0, c1-1], [0, R-1]x[c1, c2-1], [0, R-1]x[c2, C-1]
        for (int c1 = 1; c1 < C; ++c1) { 
            for (int c2 = c1 + 1; c2 < C; ++c2) { 
                long long area1 = calculate_bbox_area(ones, 0, R - 1, 0, c1 - 1);
                long long area2 = calculate_bbox_area(ones, 0, R - 1, c1, c2 - 1);
                long long area3 = calculate_bbox_area(ones, 0, R - 1, c2, C - 1);
                min_total_area = std::min(min_total_area, area1 + area2 + area3);
            }
        }

        // Case 3: One horizontal strip and two vertical strips
        // Subcase 3a: Top strip + bottom two vertical strips
        // Rectangles: [0, r-1]x[0, C-1], [r, R-1]x[0, c-1], [r, R-1]x[c, C-1]
        for (int r = 1; r < R; ++r) { 
            for (int c = 1; c < C; ++c) { 
                long long area1 = calculate_bbox_area(ones, 0, r - 1, 0, C - 1);
                long long area2 = calculate_bbox_area(ones, r, R - 1, 0, c - 1);
                long long area3 = calculate_bbox_area(ones, r, R - 1, c, C - 1);
                min_total_area = std::min(min_total_area, area1 + area2 + area3);
            }
        }

        // Subcase 3b: Bottom strip + top two vertical strips
        // Rectangles: [0, r-1]x[0, c-1], [0, r-1]x[c, C-1], [r, R-1]x[0, C-1]
        for (int r = 1; r < R; ++r) { 
            for (int c = 1; c < C; ++c) { 
                long long area1 = calculate_bbox_area(ones, 0, r - 1, 0, c - 1);
                long long area2 = calculate_bbox_area(ones, 0, r - 1, c, C - 1);
                long long area3 = calculate_bbox_area(ones, r, R - 1, 0, C - 1);
                min_total_area = std::min(min_total_area, area1 + area2 + area3);
            }
        }

        // Case 4: One vertical strip and two horizontal strips
        // Subcase 4a: Left strip + right two horizontal strips
        // Rectangles: [0, R-1]x[0, c-1], [0, r-1]x[c, C-1], [r, R-1]x[c, C-1]
        for (int c = 1; c < C; ++c) { 
            for (int r = 1; r < R; ++r) { 
                long long area1 = calculate_bbox_area(ones, 0, R - 1, 0, c - 1);
                long long area2 = calculate_bbox_area(ones, 0, r - 1, c, C - 1);
                long long area3 = calculate_bbox_area(ones, r, R - 1, c, C - 1);
                min_total_area = std::min(min_total_area, area1 + area2 + area3);
            }
        }

        // Subcase 4b: Right strip + left two horizontal strips
        // Rectangles: [0, r-1]x[0, c-1], [r, R-1]x[0, c-1], [0, R-1]x[c, C-1]
        for (int c = 1; c < C; ++c) { 
            for (int r = 1; r < R; ++r) { 
                long long area1 = calculate_bbox_area(ones, 0, r - 1, 0, c - 1);
                long long area2 = calculate_bbox_area(ones, r, R - 1, 0, c - 1);
                long long area3 = calculate_bbox_area(ones, 0, R - 1, c, C - 1);
                min_total_area = std::min(min_total_area, area1 + area2 + area3);
            }
        }

        return static_cast<int>(min_total_area);
    }
};