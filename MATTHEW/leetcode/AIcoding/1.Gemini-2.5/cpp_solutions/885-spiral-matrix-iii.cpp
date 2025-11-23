#include <vector>

class Solution {
public:
    std::vector<std::vector<int>> spiralMatrixIII(int rows, int cols, int rStart, int cStart) {
        std::vector<std::vector<int>> result;
        result.reserve(rows * cols);

        int r = rStart;
        int c = cStart;

        // Directions: Right, Down, Left, Up
        int dr[] = {0, 1, 0, -1}; 
        int dc[] = {1, 0, -1, 0}; 

        int current_dir_idx = 0; // Start with Right (index 0)
        int steps_to_take = 1;   // Number of steps to take in the current direction
        int turn_count = 0;      // Counts how many times direction has changed

        // Use a visited array to ensure each grid cell is added only once
        std::vector<std::vector<bool>> visited(rows, std::vector<bool>(cols, false));

        // Add the starting cell if it's within bounds
        if (rStart >= 0 && rStart < rows && cStart >= 0 && cStart < cols) {
            result.push_back({rStart, cStart});
            visited[rStart][cStart] = true;
        }

        // Continue spiraling until all cells in the grid have been visited
        while (result.size() < rows * cols) {
            // Take 'steps_to_take' steps in the current direction
            for (int k = 0; k < steps_to_take; ++k) {
                r += dr[current_dir_idx];
                c += dc[current_dir_idx];

                // Check if the new cell is within bounds and not yet visited
                if (r >= 0 && r < rows && c >= 0 && c < cols && !visited[r][c]) {
                    result.push_back({r, c});
                    visited[r][c] = true;
                }

                // If all cells are collected, we can stop early
                if (result.size() == rows * cols) {
                    break; 
                }
            }

            // If all cells are collected, break the outer loop too
            if (result.size() == rows * cols) {
                break; 
            }

            // Change direction
            current_dir_idx = (current_dir_idx + 1) % 4;
            turn_count++;

            // After every two turns (e.g., Right then Down, or Left then Up),
            // the number of steps to take in a direction increases by 1.
            if (turn_count % 2 == 0) {
                steps_to_take++;
            }
        }

        return result;
    }
};