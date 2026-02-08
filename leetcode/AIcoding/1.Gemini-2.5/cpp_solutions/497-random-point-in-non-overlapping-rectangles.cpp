#include <vector>
#include <random>
#include <algorithm> // For std::upper_bound
#include <numeric>   // For std::iota if needed, or just general utility, not strictly for this problem

class Solution {
private:
    std::vector<std::vector<int>> rects_data;
    std::vector<long long> prefix_sums;
    std::mt19937 gen; 

public:
    Solution(std::vector<std::vector<int>>& rects) : rects_data(rects) {
        gen.seed(std::random_device()()); 

        long long current_sum = 0;
        for (const auto& rect : rects_data) {
            // Calculate width and height, ensuring intermediate calculations use long long to prevent overflow
            long long width = (long long)rect[2] - rect[0] + 1;
            long long height = (long long)rect[3] - rect[1] + 1;
            current_sum += width * height;
            prefix_sums.push_back(current_sum);
        }
    }

    std::vector<int> pick() {
        // 1. Pick a rectangle based on its area using a weighted random selection
        // Generate a random number between 0 (inclusive) and total_area (exclusive)
        // std::uniform_int_distribution range is inclusive, so [0, prefix_sums.back() - 1]
        std::uniform_int_distribution<long long> dist_area(0, prefix_sums.back() - 1);
        long long target_area = dist_area(gen);

        // Find the index of the chosen rectangle using binary search on prefix_sums
        // std::upper_bound returns an iterator to the first element *greater than* target_area
        auto it = std::upper_bound(prefix_sums.begin(), prefix_sums.end(), target_area);
        int rect_idx = std::distance(prefix_sums.begin(), it);

        // 2. Pick a random point within the chosen rectangle
        const auto& rect = rects_data[rect_idx];
        int x1 = rect[0];
        int y1 = rect[1];
        int x2 = rect[2];
        int y2 = rect[3];

        // Generate random x and y coordinates within the chosen rectangle's bounds
        std::uniform_int_distribution<int> dist_x(x1, x2);
        std::uniform_int_distribution<int> dist_y(y1, y2);

        int x = dist_x(gen);
        int y = dist_y(gen);

        return {x, y};
    }
};