#include <vector>
#include <numeric>
#include <algorithm>
#include <functional> // For std::function
#include <cstring>    // For std::memset

int M_rows, N_cols;

int adj_scores[3][3] = {
    {0, 0, 0},
    {0, -60, -10}, // I-I (-30 for I1, -30 for I2 = -60 total)
                   // I-E (-30 for I, +20 for E = -10 total)
    {0, -10, 40}   // E-I (+20 for E, -30 for I = -10 total)
                   // E-E (+20 for E1, +20 for E2 = +40 total)
};

int base_scores[3] = {0, 120, 40}; // 0: empty, 1: introvert, 2: extrovert

int memo[6][1 << 10][7][7];

inline int get_person_type(int mask, int col) {
    return (mask >> (2 * col)) & 3;
}

inline int set_person_type(int mask, int col, int type) {
    mask &= ~(3 << (2 * col)); // Clear bits for this column
    mask |= (type << (2 * col)); // Set new bits
    return mask;
}

int solve(int r, int prev_row_mask, int intro_left, int extro_left) {
    // Base case: All rows processed
    if (r == M_rows) {
        return 0;
    }

    // Memoization check
    if (memo[r][prev_row_mask][intro_left][extro_left] != -1) {
        return memo[r][prev_row_mask][intro_left][extro_left];
    }

    int max_happiness = -2e9; // Initialize with a very small number

    // Recursive helper to generate all valid current_row_masks for the current row 'r'
    // col: current column being considered for placement in the current row
    // current_row_mask_building: the mask for the current row being constructed
    // current_row_intro_count: number of introverts placed in current_row_mask_building so far
    // current_row_extro_count: number of extroverts placed in current_row_mask_building so far
    std::function<void(int, int, int, int)> generate_masks =
        [&](int col, int current_row_mask_building, int current_row_intro_count, int current_row_extro_count) {
        // Base case for generating current row mask: all columns processed for this row
        if (col == N_cols) {
            // This current_row_mask_building is a complete mask for row r
            // Now, calculate happiness for this specific row configuration and recurse for the next row

            // Calculate base happiness and horizontal adjacencies for current_row_mask_building
            int current_row_happiness = 0;
            for (int c_idx = 0; c_idx < N_cols; ++c_idx) {
                int person_type = get_person_type(current_row_mask_building, c_idx);
                current_row_happiness += base_scores[person_type];
                if (c_idx > 0) { // Check horizontal adjacency with (r, c_idx-1)
                    int prev_person_type = get_person_type(current_row_mask_building, c_idx - 1);
                    current_row_happiness += adj_scores[prev_person_type][person_type];
                }
            }

            // Calculate happiness from vertical adjacencies between prev_row_mask and current_row_mask_building
            int inter_row_happiness = 0;
            for (int c_idx = 0; c_idx < N_cols; ++c_idx) {
                int prev_person_type = get_person_type(prev_row_mask, c_idx);
                int current_person_type = get_person_type(current_row_mask_building, c_idx);
                inter_row_happiness += adj_scores[prev_person_type][current_person_type];
            }

            // Total happiness for this path (current row's happiness + recursive call for next row)
            int total_happiness = current_row_happiness + inter_row_happiness;
            total_happiness += solve(r + 1, current_row_mask_building,
                                     intro_left - current_row_intro_count,
                                     extro_left - current_row_extro_count);

            max_happiness = std::max(max_happiness, total_happiness);
            return;
        }

        // Recursive step: Try placing empty, introvert, or extrovert at current column 'col'

        // Option 1: Place Empty (00)
        generate_masks(col + 1, current_row_mask_building, current_row_intro_count, current_row_extro_count);

        // Option 2: Place Introvert (01)
        if (current_row_intro_count < intro_left) { // Check if we have introverts left globally
            int new_mask = set_person_type(current_row_mask_building, col, 1);
            generate_masks(col + 1, new_mask, current_row_intro_count + 1, current_row_extro_count);
        }

        // Option 3: Place Extrovert (10)
        if (current_row_extro_count < extro_left) { // Check if we have extroverts left globally
            int new_mask = set_person_type(current_row_mask_building, col, 2);
            generate_masks(col + 1, new_mask, current_row_intro_count, current_row_extro_count + 1);
        }
    };

    // Initial call to generate_masks for the current row 'r'
    generate_masks(0, 0, 0, 0);

    return memo[r][prev_row_mask][intro_left][extro_left] = max_happiness;
}

class Solution {
public:
    int maximizeGridHappiness(int m, int n, int introverts, int extroverts) {
        M_rows = m;
        N_cols = n;

        // Initialize memoization table with -1
        std::memset(memo, -1, sizeof(memo));

        // Start DP from row 0, with an empty previous row (mask 0)
        return solve(0, 0, introverts, extroverts);
    }
};