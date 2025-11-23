#include <vector>
#include <string>
#include <set>
#include <utility> // For std::pair

class Solution {
public:
    std::vector<bool> robot(std::string command, std::vector<std::vector<int>>& obstacles) {
        std::set<std::pair<int, int>> visited_points_in_cycle;
        int current_x = 0;
        int current_y = 0;

        visited_points_in_cycle.insert({0, 0});

        for (char c : command) {
            if (c == 'U') {
                current_y++;
            } else { // c == 'R'
                current_x++;
            }
            visited_points_in_cycle.insert({current_x, current_y});
        }

        int dx = current_x; // Net x displacement after one full command cycle
        int dy = current_y; // Net y displacement after one full command cycle

        std::vector<bool> results;
        results.reserve(obstacles.size());

        for (const auto& obstacle : obstacles) {
            int ox = obstacle[0];
            int oy = obstacle[1];

            bool hit = false;

            // Obstacles must have non-negative coordinates to be reachable from (0,0)
            // with only 'U' and 'R' moves.
            // Problem constraints usually guarantee ox, oy >= 0.
            if (ox < 0 || oy < 0) {
                results.push_back(false);
                continue;
            }

            for (const auto& p : visited_points_in_cycle) {
                int px = p.first;
                int py = p.second;

                // If obstacle is "behind" the current point in the cycle,
                // it's impossible to reach with non-negative 'm' cycles,
                // as dx and dy are always non-negative (robot only moves U/R).
                if (ox < px || oy < py) {
                    continue;
                }

                int rem_x = ox - px;
                int rem_y = oy - py;

                // Case 1: Robot returns to origin (or same relative position) after each cycle
                if (dx == 0 && dy == 0) {
                    if (rem_x == 0 && rem_y == 0) {
                        hit = true;
                        break;
                    }
                }
                // Case 2: dx is 0, but dy is not
                else if (dx == 0) {
                    if (rem_x == 0 && rem_y % dy == 0) {
                        // m = rem_y / dy. Since rem_y >= 0 and dy > 0, m >= 0 is guaranteed.
                        hit = true;
                        break;
                    }
                }
                // Case 3: dy is 0, but dx is not
                else if (dy == 0) {
                    if (rem_y == 0 && rem_x % dx == 0) {
                        // m = rem_x / dx. Since rem_x >= 0 and dx > 0, m >= 0 is guaranteed.
                        hit = true;
                        break;
                    }
                }
                // Case 4: Both dx and dy are non-zero
                else {
                    if (rem_x % dx == 0 && rem_y % dy == 0) {
                        int m_x = rem_x / dx;
                        int m_y = rem_y / dy;
                        // m_x and m_y are guaranteed to be non-negative because rem_x, rem_y >= 0 and dx, dy > 0.
                        if (m_x == m_y) {
                            hit = true;
                            break;
                        }
                    }
                }
            }
            results.push_back(hit);
        }

        return results;
    }
};