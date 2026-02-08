class Solution {
public:
    std::vector<std::vector<int>> reconstructMatrix(int upper, int lower, std::vector<int>& colsum) {
        int n = colsum.size();
        std::vector<std::vector<int>> result(2, std::vector<int>(n));

        long long total_col_sum = 0;
        for (int sum : colsum) {
            total_col_sum += sum;
        }

        if (total_col_sum != upper + lower) {
            return {};
        }

        for (int j = 0; j < n; ++j) {
            if (colsum[j] == 2) {
                result[0][j] = 1;
                result[1][j] = 1;
                upper--;
                lower--;
            }
        }

        if (upper < 0 || lower < 0) {
            return {};
        }

        for (int j = 0; j < n; ++j) {
            if (colsum[j] == 1) {
                if (upper > 0) {
                    result[0][j] = 1;
                    upper--;
                } else if (lower > 0) {
                    result[1][j] = 1;
                    lower--;
                } else {
                    return {};
                }
            }
        }

        if (upper == 0 && lower == 0) {
            return result;
        } else {
            return {};
        }
    }
};