#include <vector>
#include <algorithm>
#include <map>
#include <climits> // Not strictly needed, but often included for min/max operations

class Solution {
public:
    long long maxBuilding(int n, std::vector<std::vector<int>>& restrictions) {
        std::map<int, int> effective_restrictions_map;

        // Building 1 (location 1) must have height 0.
        // This is a mandatory restriction.
        effective_restrictions_map[1] = 0;

        // Process input restrictions. If multiple restrictions exist for the same building,
        // the most stringent (minimum height) applies.
        for (const auto& r : restrictions) {
            int pos = r[0];
            int h = r[1];
            if (effective_restrictions_map.count(pos)) {
                effective_restrictions_map[pos] = std::min(effective_restrictions_map[pos], h);
            } else {
                effective_restrictions_map[pos] = h;
            }
        }

        // Convert the map to a vector of pairs for easier indexed access.
        // std::map iterates in key-sorted order, so the vector will be sorted by position.
        std::vector<std::pair<int, int>> effective_restrictions_vec;
        for (const auto& entry : effective_restrictions_map) {
            effective_restrictions_vec.push_back(entry);
        }

        // Left-to-right pass: Adjust heights based on the previous building's height and distance.
        // For any two adjacent buildings `i-1` and `i`, the height of `i` cannot exceed
        // `height[i-1] + (position[i] - position[i-1])`.
        for (size_t i = 1; i < effective_restrictions_vec.size(); ++i) {
            effective_restrictions_vec[i].second = std::min(
                effective_restrictions_vec[i].second,
                effective_restrictions_vec[i-1].second + (effective_restrictions_vec[i].first - effective_restrictions_vec[i-1].first)
            );
        }

        // Right-to-left pass: Adjust heights based on the next building's height and distance.
        // For any two adjacent buildings `i` and `i+1`, the height of `i` cannot exceed
        // `height[i+1] + (position[i+1] - position[i])`.
        for (int i = effective_restrictions_vec.size() - 2; i >= 0; --i) {
            effective_restrictions_vec[i].second = std::min(
                effective_restrictions_vec[i].second,
                effective_restrictions_vec[i+1].second + (effective_restrictions_vec[i+1].first - effective_restrictions_vec[i].first)
            );
        }

        long long max_overall_height = 0;

        // Calculate the maximum possible height among all buildings.
        // This includes restricted buildings and buildings between them.
        for (size_t i = 0; i < effective_restrictions_vec.size(); ++i) {
            // First, update with the height of the current restricted building itself.
            max_overall_height = std::max(max_overall_height, (long long)effective_restrictions_vec[i].second);

            // If there's a next restricted building, consider the segment between them.
            if (i + 1 < effective_restrictions_vec.size()) {
                long long p1 = effective_restrictions_vec[i].first;
                long long h1 = effective_restrictions_vec[i].second;
                long long p2 = effective_restrictions_vec[i+1].first;
                long long h2 = effective_restrictions_vec[i+1].second;

                // The maximum height for any building in the segment [p1, p2]
                // is at the peak of the "tent" formed by the two endpoints.
                // This height is (h1 + h2 + (p2 - p1)) / 2.
                long long max_height_in_segment = (h1 + h2 + (p2 - p1)) / 2;
                max_overall_height = std::max(max_overall_height, max_height_in_segment);
            }
        }

        // Finally, consider the segment from the last restricted building to building 'n'.
        // Heights can increase by 1 for each unit of distance from the last restricted building.
        long long last_pos = effective_restrictions_vec.back().first;
        long long last_h = effective_restrictions_vec.back().second;
        max_overall_height = std::max(max_overall_height, last_h + (n - last_pos));

        return max_overall_height;
    }
};