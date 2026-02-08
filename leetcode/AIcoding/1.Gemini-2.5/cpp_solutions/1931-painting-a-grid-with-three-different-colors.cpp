#include <vector>
#include <map>
#include <numeric>

class Solution {
public:
    int m_rows;
    const int MOD = 1e9 + 7;

    int get_color(int mask, int row) {
        return (mask >> (row * 2)) & 3;
    }

    void generate_masks(int row, int current_mask, std::vector<int>& valid_masks) {
        if (row == m_rows) {
            valid_masks.push_back(current_mask);
            return;
        }

        for (int c = 0; c < 3; ++c) {
            if (row > 0 && c == get_color(current_mask, row - 1)) {
                continue;
            }
            generate_masks(row + 1, current_mask | (c << (row * 2)), valid_masks);
        }
    }

    bool are_adjacent(int mask1, int mask2) {
        for (int r = 0; r < m_rows; ++r) {
            if (get_color(mask1, r) == get_color(mask2, r)) {
                return false;
            }
        }
        return true;
    }

    std::vector<std::vector<long long>> multiply(const std::vector<std::vector<long long>>& A, const std::vector<std::vector<long long>>& B) {
        int size = A.size();
        std::vector<std::vector<long long>> C(size, std::vector<long long>(size, 0));
        for (int i = 0; i < size; ++i) {
            for (int j = 0; j < size; ++j) {
                for (int k = 0; k < size; ++k) {
                    C[i][j] = (C[i][j] + A[i][k] * B[k][j]) % MOD;
                }
            }
        }
        return C;
    }

    std::vector<std::vector<long long>> matrix_pow(std::vector<std::vector<long long>> A, int exp) {
        int size = A.size();
        std::vector<std::vector<long long>> res(size, std::vector<long long>(size, 0));
        for (int i = 0; i < size; ++i) {
            res[i][i] = 1;
        }

        while (exp > 0) {
            if (exp % 2 == 1) {
                res = multiply(res, A);
            }
            A = multiply(A, A);
            exp /= 2;
        }
        return res;
    }

    int paintGrid(int m, int n) {
        m_rows = m;

        std::vector<int> valid_column_masks;
        generate_masks(0, 0, valid_column_masks);

        int num_masks = valid_column_masks.size();
        if (n == 1) {
            return num_masks;
        }

        std::vector<std::vector<long long>> T(num_masks, std::vector<long long>(num_masks, 0));
        for (int i = 0; i < num_masks; ++i) {
            for (int j = 0; j < num_masks; ++j) {
                if (are_adjacent(valid_column_masks[i], valid_column_masks[j])) {
                    T[i][j] = 1;
                }
            }
        }

        std::vector<std::vector<long long>> T_pow_n_minus_1 = matrix_pow(T, n - 1);

        long long total_ways = 0;
        for (int i = 0; i < num_masks; ++i) {
            for (int j = 0; j < num_masks; ++j) {
                total_ways = (total_ways + T_pow_n_minus_1[i][j]) % MOD;
            }
        }

        return total_ways;
    }
};