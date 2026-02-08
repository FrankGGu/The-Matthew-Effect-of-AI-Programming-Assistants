#include <vector>
#include <map>
#include <algorithm>

class Solution {
public:
    std::vector<int> blockPlacementQueries(std::vector<std::vector<int>>& queries) {
        std::map<int, int> free_spaces; // key: start_coord, value: end_coord
        // Initialize with a single large free space from 0 to a sufficiently large number.
        // Max coordinate can be 10^9. Max block end can be 10^9 + 10^9 - 1 = 2*10^9 - 1.
        // So a value like 2*10^9 + 7 is safe for the "infinity" end.
        const int INF_END_COORD = 2000000000 + 7; 
        free_spaces[0] = INF_END_COORD;

        std::vector<int> results;

        for (const auto& query : queries) {
            int type = query[0];
            int x = query[1];

            if (type == 1) { // Place block
                int length = query[2];
                int block_start = x;
                int block_end = x + length - 1;

                auto it = free_spaces.upper_bound(block_start);
                if (it != free_spaces.begin()) {
                    --it;
                }

                std::vector<std::pair<int, int>> new_free_intervals;
                std::vector<int> keys_to_erase;

                // Iterate through free intervals that might overlap with the new block
                while (it != free_spaces.end() && it->first <= block_end) {
                    int current_free_start = it->first;
                    int current_free_end = it->second;

                    // If the current free interval is completely before the new block, skip it.
                    // This can happen if `it` was decremented and its end is before `block_start`.
                    if (current_free_end < block_start) {
                        ++it;
                        continue;
                    }

                    // Mark the current interval for removal (or the part of it that overlaps)
                    keys_to_erase.push_back(current_free_start);

                    // If the current free interval starts before the new block, a part of it remains free
                    if (current_free_start < block_start) {
                        new_free_intervals.push_back({current_free_start, block_start - 1});
                    }

                    // If the current free interval ends after the new block, a part of it remains free
                    if (current_free_end > block_end) {
                        new_free_intervals.push_back({block_end + 1, current_free_end});
                    }

                    ++it;
                }

                // Apply changes to the map
                for (int key : keys_to_erase) {
                    free_spaces.erase(key);
                }
                for (auto p : new_free_intervals) {
                    free_spaces[p.first] = p.second;
                }

            } else { // Query max length
                int query_start = x;
                int query_max_end = query[2];

                auto it = free_spaces.upper_bound(query_start);
                if (it != free_spaces.begin()) {
                    --it;
                }

                int current_free_start = it->first;
                int current_free_end = it->second;

                if (query_start > current_free_end) {
                    // The query_start position is not free in this interval.
                    // Since free_spaces only stores free intervals, this means query_start
                    // must be within a placed block.
                    results.push_back(0);
                } else {
                    // query_start is free. Calculate the maximum possible end position.
                    int effective_end = std::min(current_free_end, query_max_end);
                    if (effective_end < query_start) {
                        // No valid length possible (e.g., query_max_end is before query_start)
                        results.push_back(0);
                    } else {
                        results.push_back(effective_end - query_start + 1);
                    }
                }
            }
        }

        return results;
    }
};