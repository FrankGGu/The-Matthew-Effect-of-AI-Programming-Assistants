#include <vector>
#include <algorithm>

class Solution {
public:
    std::vector<int> countRectangles(std::vector<std::vector<int>>& rectangles, std::vector<std::vector<int>>& points) {
        std::vector<std::vector<int>> rects_by_height(101); 

        for (const auto& rect : rectangles) {
            int l = rect[0];
            int h = rect[1];
            if (h <= 100) { 
                rects_by_height[h].push_back(l);
            }
        }

        for (int h_idx = 1; h_idx <= 100; ++h_idx) {
            std::sort(rects_by_height[h_idx].begin(), rects_by_height[h_idx].end());
        }

        std::vector<int> ans(points.size());
        for (int i = 0; i < points.size(); ++i) {
            int xj = points[i][0];
            int yj = points[i][1];
            int count = 0;

            for (int h_idx = yj; h_idx <= 100; ++h_idx) {
                const std::vector<int>& current_lengths = rects_by_height[h_idx];
                auto it = std::lower_bound(current_lengths.begin(), current_lengths.end(), xj);
                count += (current_lengths.end() - it);
            }
            ans[i] = count;
        }

        return ans;
    }
};