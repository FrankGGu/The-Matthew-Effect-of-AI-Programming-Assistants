#include <vector>
#include <queue>
#include <unordered_set>
#include <utility> // For std::pair
#include <algorithm> // For std::max

class Solution {
public:
    // Helper function for BFS
    bool canEscape(const std::vector<int>& start, const std::vector<int>& end, 
                   const std::unordered_set<long long>& blocked_set, int max_visited_cells) {

        std::queue<std::pair<int, int>> q;
        std::unordered_set<long long> visited;

        q.push({start[0], start[1]});
        visited.insert((long long)start[0] * 1000000 + start[1]);

        int count = 0;

        // Directions: up, down, left, right
        int dr[] = {-1, 1, 0, 0};
        int dc[] = {0, 0, -1, 1};

        // Grid boundaries
        const int GRID_SIZE = 1000000;

        while (!q.empty()) {
            std::pair<int, int> curr = q.front();
            q.pop();

            // If we reached the target, we can escape
            if (curr.first == end[0] && curr.second == end[1]) {
                return true;
            }

            count++;
            // If we have visited more cells than the limit, it means we broke out of any enclosure
            // formed by the 'blocked' cells and can reach an effectively infinite area.
            if (count > max_visited_cells) {
                return true;
            }

            for (int i = 0; i < 4; ++i) {
                int nr = curr.first + dr[i];
                int nc = curr.second + dc[i];

                // Check boundaries of the large grid
                if (nr < 0 || nr >= GRID_SIZE || nc < 0 || nc >= GRID_SIZE) {
                    continue;
                }

                long long hash_val = (long long)nr * GRID_SIZE + nc;

                // If already visited or blocked, skip
                if (visited.count(hash_val) || blocked_set.count(hash_val)) {
                    continue;
                }

                visited.insert(hash_val);
                q.push({nr, nc});
            }
        }
        // If the queue becomes empty and we haven't reached target or exceeded the limit,
        // it means the start is enclosed and cannot escape.
        return false;
    }

    bool isEscapePossible(std::vector<std::vector<int>>& blocked, std::vector<int>& source, std::vector<int>& target) {
        std::unordered_set<long long> blocked_set;
        const int GRID_SIZE = 1000000;

        for (const auto& block : blocked) {
            blocked_set.insert((long long)block[0] * GRID_SIZE + block[1]);
        }

        // The maximum number of cells that can be enclosed by N obstacles is roughly N * (N - 1) / 2.
        // For N = 200 (max blocked cells), this is 200 * 199 / 2 = 19900.
        // A common and safe upper bound for the number of cells to check before assuming escape is 200 * 200.
        // This value acts as a "boundary" for the BFS. If BFS explores beyond this many cells, it's considered escaped.
        const int MAX_ENCLOSED_AREA_LIMIT = 200 * 200; 

        // We need to check two conditions:
        // 1. Can 'source' reach 'target' OR escape its local enclosure?
        // 2. Can 'target' reach 'source' OR escape its local enclosure?
        // Both conditions must be true for a path to exist.
        // If source is enclosed, canEscape(source, target, ...) returns false.
        // If target is enclosed, canEscape(target, source, ...) returns false.
        // If both can escape their enclosures (or reach each other), then they can meet in the "infinite" space.
        return canEscape(source, target, blocked_set, MAX_ENCLOSED_AREA_LIMIT) &&
               canEscape(target, source, blocked_set, MAX_ENCLOSED_AREA_LIMIT);
    }
};