#include <vector>
#include <algorithm>
#include <set>
#include <cmath> // For std::abs

struct Query {
    int preferred;
    int minSize;
    int original_index;
};

class Solution {
public:
    std::vector<int> closestRoom(std::vector<std::vector<int>>& rooms, std::vector<std::vector<int>>& queries) {
        std::sort(rooms.begin(), rooms.end(), [](const std::vector<int>& a, const std::vector<int>& b) {
            return a[1] > b[1]; // Sort rooms by size (index 1) in descending order
        });

        std::vector<Query> sorted_queries(queries.size());
        for (int i = 0; i < queries.size(); ++i) {
            sorted_queries[i] = {queries[i][0], queries[i][1], i};
        }

        std::sort(sorted_queries.begin(), sorted_queries.end(), [](const Query& a, const Query& b) {
            return a.minSize > b.minSize; // Sort queries by minSize in descending order
        });

        std::vector<int> ans(queries.size());
        std::set<int> available_room_ids; // Stores room IDs that meet current minSize criteria
        int room_ptr = 0; // Pointer for iterating through sorted rooms

        for (const auto& q : sorted_queries) {
            int preferred = q.preferred;
            int minSize = q.minSize;
            int original_index = q.original_index;

            // Add all rooms whose size is greater than or equal to the current query's minSize
            // These rooms remain available for subsequent queries with smaller minSize
            while (room_ptr < rooms.size() && rooms[room_ptr][1] >= minSize) {
                available_room_ids.insert(rooms[room_ptr][0]);
                room_ptr++;
            }

            if (available_room_ids.empty()) {
                ans[original_index] = -1;
            } else {
                int best_room_id = -1;
                long long min_diff = -1; // Use long long for difference to handle potential large values, though int is usually sufficient for problem constraints.

                // Find the first room ID that is greater than or equal to preferred
                auto it = available_room_ids.lower_bound(preferred);

                // Candidate 1: Room with ID >= preferred (if exists)
                if (it != available_room_ids.end()) {
                    int current_room_id = *it;
                    long long current_diff = std::abs((long long)current_room_id - preferred);
                    best_room_id = current_room_id;
                    min_diff = current_diff;
                }

                // Candidate 2: Room with ID < preferred (if exists)
                if (it != available_room_ids.begin()) {
                    auto prev_it = std::prev(it);
                    int current_room_id = *prev_it;
                    long long current_diff = std::abs((long long)current_room_id - preferred);

                    if (best_room_id == -1 || current_diff < min_diff) {
                        best_room_id = current_room_id;
                        min_diff = current_diff;
                    } else if (current_diff == min_diff) {
                        // Tie-breaking: if differences are equal, choose the smaller room ID
                        if (current_room_id < best_room_id) {
                            best_room_id = current_room_id;
                        }
                    }
                }
                ans[original_index] = best_room_id;
            }
        }
        return ans;
    }
};