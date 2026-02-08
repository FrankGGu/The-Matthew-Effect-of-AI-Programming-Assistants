class Solution {
public:
    int maxStudents(std::vector<std::vector<char>>& seats) {
        int m = seats.size();
        int n = seats[0].size();

        std::vector<int> broken_masks(m);
        for (int i = 0; i < m; ++i) {
            for (int j = 0; j < n; ++j) {
                if (seats[i][j] == '#') {
                    broken_masks[i] |= (1 << j);
                }
            }
        }

        std::vector<std::vector<int>> memo(m, std::vector<int>(1 << n, -1));

        return solve(0, 0, m, n, broken_masks, memo);
    }

private:
    int solve(int row_idx, int prev_row_mask, int m, int n, const std::vector<int>& broken_masks, std::vector<std::vector<int>>& memo) {
        if (row_idx == m) {
            return 0;
        }
        if (memo[row_idx][prev_row_mask] != -1) {
            return memo[row_idx][prev_row_mask];
        }

        int max_students_in_current_and_future_rows = 0;

        for (int current_row_mask = 0; current_row_mask < (1 << n); ++current_row_mask) {
            // Condition 1: No two students in current_row_mask can be adjacent in the same row
            if ((current_row_mask & (current_row_mask << 1)) != 0) {
                continue;
            }

            // Condition 2: Students can only be placed in '.' seats
            if ((current_row_mask & broken_masks[row_idx]) != 0) {
                continue;
            }

            // Condition 3: Check compatibility with prev_row_mask (diagonal adjacency)
            // No student in current_row_mask can be diagonally adjacent to a student in prev_row_mask
            if ((current_row_mask & (prev_row_mask << 1)) != 0) {
                continue;
            }
            if ((current_row_mask & (prev_row_mask >> 1)) != 0) {
                continue;
            }

            int students_in_current_row = __builtin_popcount(current_row_mask);
            max_students_in_current_and_future_rows = std::max(max_students_in_current_and_future_rows,
                                                          students_in_current_row + solve(row_idx + 1, current_row_mask, m, n, broken_masks, memo));
        }

        return memo[row_idx][prev_row_mask] = max_students_in_current_and_future_rows;
    }
};