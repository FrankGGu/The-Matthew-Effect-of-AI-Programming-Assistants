#include <string>
#include <cmath> // For std::abs

class Solution {
public:
    std::string alphabetBoardPath(std::string target) {
        std::string result = "";
        int curr_r = 0;
        int curr_c = 0;

        for (char c : target) {
            int next_r, next_c;
            int val = c - 'a';
            next_r = val / 5;
            next_c = val % 5;

            // Calculate differences
            int dr = next_r - curr_r;
            int dc = next_c - curr_c;

            // Special handling for 'z' when moving TO 'z'
            // If target is 'z' (5,0), and current column is not 0,
            // we must move Left first to avoid going to (5, current_c) which is off-board.
            if (c == 'z') {
                for (int i = 0; i < std::abs(dc); ++i) {
                    result += 'L';
                }
                for (int i = 0; i < std::abs(dr); ++i) {
                    result += 'D';
                }
            }
            // Special handling for 'z' when moving FROM 'z'
            // If current position is 'z' (5,0), and target column is not 0,
            // we must move Up first to avoid going to (5, target_c) which is off-board.
            else if (curr_r == 5 && curr_c == 0) {
                for (int i = 0; i < std::abs(dr); ++i) {
                    result += 'U';
                }
                for (int i = 0; i < std::abs(dc); ++i) {
                    result += 'R';
                }
            }
            // General case: neither current nor target is 'z' in a problematic way
            else {
                // Vertical moves
                if (dr < 0) { // Move Up
                    for (int i = 0; i < std::abs(dr); ++i) {
                        result += 'U';
                    }
                } else { // Move Down
                    for (int i = 0; i < std::abs(dr); ++i) {
                        result += 'D';
                    }
                }
                // Horizontal moves
                if (dc < 0) { // Move Left
                    for (int i = 0; i < std::abs(dc); ++i) {
                        result += 'L';
                    }
                } else { // Move Right
                    for (int i = 0; i < std::abs(dc); ++i) {
                        result += 'R';
                    }
                }
            }

            result += '!';
            curr_r = next_r;
            curr_c = next_c;
        }

        return result;
    }
};