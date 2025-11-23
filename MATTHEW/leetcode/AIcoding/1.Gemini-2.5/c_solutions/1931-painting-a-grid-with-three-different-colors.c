#include <stdlib.h>

static int valid_patterns_storage[48][5];
static int num_valid_patterns_g = 0; // Global counter for valid patterns
static int compatibility_matrix_g[48][48]; // compatibility_matrix_g[i][j] = 1 if pattern i and pattern j are compatible

static const int MOD = 1e9 + 7;

static int is_valid_column_pattern(int m, int* pattern) {
    for (int i = 0; i < m - 1; ++i) {
        if (pattern[i] == pattern[i+1]) {
            return 0;
        }
    }
    return 1;
}

static int are_compatible(int m, int* pattern1, int* pattern2) {
    for (int i = 0; i < m; ++i) {
        if (pattern1[i] == pattern2[i]) {
            return 0;
        }
    }
    return 1;
}

static void generate_patterns_recursive(int m, int row_idx, int* current_pattern_buffer) {
    if (row_idx == m) {
        if (is_valid_column_pattern(m, current_pattern_buffer)) {
            for (int i = 0; i < m; ++i) {
                valid_patterns_storage[num_valid_patterns_g][i] = current_pattern_buffer[i];
            }
            num_valid_patterns_g++;
        }
        return;
    }

    for (int color = 0; color < 3; ++color) {
        if (row_idx > 0 && current_pattern_buffer[row_idx - 1] == color) {
            continue;
        }
        current_pattern_buffer[row_idx] = color;
        generate_patterns_recursive(m, row_idx + 1, current_pattern_buffer);
    }
}

static void precompute(int m) {
    num_valid_patterns_g = 0;
    int current_pattern_buffer[5];
    generate_patterns_recursive(m, 0, current_pattern_buffer);

    for (int i = 0; i < num_valid_patterns_g; ++i) {
        for (int j = 0; j < num_valid_patterns_g; ++j) {
            compatibility_matrix_g[i][j] = are_compatible(m, valid_patterns_storage[i], valid_patterns_storage[j]);
        }
    }
}

static int dp_prev[48];
static int dp_curr[48];

int paintGrid(int m, int n) {
    precompute(m);

    for (int j = 0; j < num_valid_patterns_g; ++j) {
        dp_prev[j] = 1;
    }

    for (int i = 1; i < n; ++i) {
        for (int current_pattern_idx = 0; current_pattern_idx < num_valid_patterns_g; ++current_pattern_idx) {
            dp_curr[current_pattern_idx] = 0;
            for (int prev_pattern_idx = 0; prev_pattern_idx < num_valid_patterns_g; ++prev_pattern_idx) {
                if (compatibility_matrix_g[prev_pattern_idx][current_pattern_idx]) {
                    dp_curr[current_pattern_idx] = (dp_curr[current_pattern_idx] + dp_prev[prev_pattern_idx]) % MOD;
                }
            }
        }
        for (int j = 0; j < num_valid_patterns_g; ++j) {
            dp_prev[j] = dp_curr[j];
        }
    }

    long long total_ways = 0;
    for (int j = 0; j < num_valid_patterns_g; ++j) {
        total_ways = (total_ways + dp_prev[j]) % MOD;
    }

    return (int)total_ways;
}