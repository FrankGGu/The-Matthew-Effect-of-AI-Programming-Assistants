#include <vector>
#include <queue>
#include <set>
#include <tuple>
#include <algorithm>

class Solution {
public:
    int containVirus(std::vector<std::vector<int>>& grid) {
        int R = grid.size();
        if (R == 0) return 0;
        int C = grid[0].size();
        if (C == 0) return 0;

        int total_walls = 0;

        int dr[] = {-1, 1, 0, 0};
        int dc[] = {0, 0, -1, 1};

        while (true) {
            std::vector<std::vector<bool>> visited_for_region_finding(R, std::vector<bool>(C, false));
            // Each element: {infected_cells_in_region, uninfected_neighbors_of_region, num_walls_needed}
            std::vector<std::tuple<std::set<std::pair<int, int>>, std::set<std::pair<int, int>>, int>> regions_info;

            for (int r = 0; r < R; ++r) {
                for (int c = 0; c < C; ++c) {
                    if (grid[r][c] == 1 && !visited_for_region_finding[r][c]) {
                        std::set<std::pair<int, int>> current_region_cells;
                        std::set<std::pair<int, int>> current_region_neighbors;

                        std::queue<std::pair<int, int>> q;
                        q.push({r, c});
                        visited_for_region_finding[r][c] = true;
                        current_region_cells.insert({r, c});

                        while (!q.empty()) {
                            std::pair<int, int> curr = q.front();
                            q.pop();
                            int curr_r = curr.first;
                            int curr_c = curr.second;

                            for (int i = 0; i < 4; ++i) {
                                int nr = curr_r + dr[i];
                                int nc = curr_c + dc[i];

                                if (nr >= 0 && nr < R && nc >= 0 && nc < C) {
                                    if (grid[nr][nc] == 1 && !visited_for_region_finding[nr][nc]) {
                                        visited_for_region_finding[nr][nc] = true;
                                        q.push({nr, nc});
                                        current_region_cells.insert({nr, nc});
                                    } else if (grid[nr][nc] == 0) { // Uninfected cell
                                        current_region_neighbors.insert({nr, nc});
                                    }
                                }
                            }
                        }

                        // Only consider regions that can spread (have uninfected neighbors)
                        if (!current_region_neighbors.empty()) {
                            regions_info.emplace_back(current_region_cells, current_region_neighbors, current_region_neighbors.size());
                        }
                    }
                }
            }

            if (regions_info.empty()) {
                break; // No more infected regions that can spread
            }

            // Find the region that would infect the most uninfected cells
            int max_neighbors_count = -1;
            int best_region_idx = -1;
            for (int i = 0; i < regions_info.size(); ++i) {
                if (std::get<1>(regions_info[i]).size() > max_neighbors_count) {
                    max_neighbors_count = std::get<1>(regions_info[i]).size();
                    best_region_idx = i;
                }
            }

            // Add walls for the chosen region
            total_walls += std::get<2>(regions_info[best_region_idx]);

            // Contain the chosen region
            for (const auto& cell : std::get<0>(regions_info[best_region_idx])) {
                grid[cell.first][cell.second] = 2; // Mark as contained
            }

            // Spread other regions
            for (int i = 0; i < regions_info.size(); ++i) {
                if (i != best_region_idx) {
                    for (const auto& cell : std::get<1>(regions_info[i])) {
                        if (grid[cell.first][cell.second] == 0) {
                            grid[cell.first][cell.second] = 1;
                        }
                    }
                }
            }
        }

        return total_walls;
    }
};