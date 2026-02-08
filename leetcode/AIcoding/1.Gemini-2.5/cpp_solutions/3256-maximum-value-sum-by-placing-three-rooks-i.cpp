#include <vector>
#include <algorithm>
#include <cmath>
#include <tuple>

class Solution {
public:
    int N, M;
    std::vector<std::vector<int>> grid_data;
    std::vector<std::vector<std::vector<std::vector<int>>>> st;
    std::vector<int> log_table;

    void build_sparse_table() {
        N = grid_data.size();
        M = grid_data[0].size();

        log_table.resize(std::max(N, M) + 1);
        log_table[1] = 0;
        for (int i = 2; i <= std::max(N, M); ++i) {
            log_table[i] = log_table[i / 2] + 1;
        }

        int max_pr = log_table[N];
        int max_pc = log_table[M];
        st.resize(N, std::vector<std::vector<std::vector<int>>>(M, std::vector<std::vector<int>>(max_pr + 1, std::vector<int>(max_pc + 1))));

        for (int r = 0; r < N; ++r) {
            for (int c = 0; c < M; ++c) {
                st[r][c][0][0] = grid_data[r][c];
            }
        }

        // Fill for pr=0 (1xM blocks)
        for (int pc = 1; pc <= max_pc; ++pc) {
            for (int r = 0; r < N; ++r) {
                for (int c = 0; c + (1 << pc) <= M; ++c) {
                    st[r][c][0][pc] = std::max(st[r][c][0][pc-1], st[r][c + (1 << (pc-1))][0][pc-1]);
                }
            }
        }

        // Fill for pr>0 (NxM blocks)
        for (int pr = 1; pr <= max_pr; ++pr) {
            for (int pc = 0; pc <= max_pc; ++pc) {
                for (int r = 0; r + (1 << pr) <= N; ++r) {
                    for (int c = 0; c + (1 << pc) <= M; ++c) {
                        st[r][c][pr][pc] = std::max(st[r][c][pr-1][pc], st[r + (1 << (pr-1))][c][pr-1][pc]);
                    }
                }
            }
        }
    }

    int query_rmq(int r1, int c1, int r2, int c2) { // inclusive [r1, r2], [c1, c2]
        if (r1 > r2 || c1 > c2) return 0; // Invalid range, return 0 as grid values are >= 1
        int pr = log_table[r2 - r1 + 1];
        int pc = log_table[c2 - c1 + 1];
        int val1 = st[r1][c1][pr][pc];
        int val2 = st[r2 - (1 << pr) + 1][c1][pr][pc];
        int val3 = st[r1][c2 - (1 << pc) + 1][pr][pc];
        int val4 = st[r2 - (1 << pr) + 1][c2 - (1 << pc) + 1][pr][pc];
        return std::max({val1, val2, val3, val4});
    }

    long long maximumValueSum(std::vector<std::vector<int>>& grid) {
        grid_data = grid;
        build_sparse_table();

        long long max_total_sum = 0;

        for (int r1 = 0; r1 < N; ++r1) {
            for (int c1 = 0; c1 < M; ++c1) {
                for (int r2 = 0; r2 < N; ++r2) {
                    if (r2 == r1) continue;
                    for (int c2 = 0; c2 < M; ++c2) {
                        if (c2 == c1) continue;

                        long long current_two_rooks_sum = (long long)grid_data[r1][c1] + grid_data[r2][c2];

                        long long max_val_r3_c3 = 0;

                        std::vector<std::pair<int, int>> r_ranges;
                        if (std::min(r1, r2) > 0) {
                            r_ranges.push_back({0, std::min(r1, r2) - 1});
                        }
                        if (std::min(r1, r2) + 1 <= std::max(r1, r2) - 1) {
                            r_ranges.push_back({std::min(r1, r2) + 1, std::max(r1, r2) - 1});
                        }
                        if (std::max(r1, r2) + 1 < N) {
                            r_ranges.push_back({std::max(r1, r2) + 1, N - 1});
                        }

                        std::vector<std::pair<int, int>> c_ranges;
                        if (std::min(c1, c2) > 0) {
                            c_ranges.push_back({0, std::min(c1, c2) - 1});
                        }
                        if (std::min(c1, c2) + 1 <= std::max(c1, c2) - 1) {
                            c_ranges.push_back({std::min(c1, c2) + 1, std::max(c1, c2) - 1});
                        }
                        if (std::max(c1, c2) + 1 < M) {
                            c_ranges.push_back({std::max(c1, c2) + 1, M - 1});
                        }

                        for (const auto& r_range : r_ranges) {
                            for (const auto& c_range : c_ranges) {
                                max_val_r3_c3 = std::max(max_val_r3_c3, (long long)query_rmq(r_range.first, c_range.first, r_range.second, c_range.second));
                            }
                        }

                        if (max_val_r3_c3 > 0) { // grid values are >= 1, so 0 means no valid cell found
                            max_total_sum = std::max(max_total_sum, current_two_rooks_sum + max_val_r3_c3);
                        }
                    }
                }
            }
        }

        return max_total_sum;
    }
};