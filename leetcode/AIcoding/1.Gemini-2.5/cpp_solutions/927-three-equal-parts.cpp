#include <vector>
#include <numeric>

class Solution {
public:
    std::vector<int> threeEqualParts(std::vector<int>& arr) {
        int n = arr.size();
        std::vector<int> ones_indices;
        for (int i = 0; i < n; ++i) {
            if (arr[i] == 1) {
                ones_indices.push_back(i);
            }
        }

        int total_ones = ones_indices.size();

        if (total_ones == 0) {
            return {0, 2};
        }

        if (total_ones % 3 != 0) {
            return {-1, -1};
        }

        int k = total_ones / 3;

        int p1_first_one_idx = ones_indices[0];
        int p1_last_one_idx = ones_indices[k - 1];

        int p2_first_one_idx = ones_indices[k];
        int p2_last_one_idx = ones_indices[2 * k - 1];

        int p3_first_one_idx = ones_indices[2 * k];
        int p3_last_one_idx = ones_indices[3 * k - 1];

        int num_trailing_zeros_p3 = n - 1 - p3_last_one_idx;

        int len_significant_part = n - p3_first_one_idx;

        for (int i = 0; i < len_significant_part; ++i) {
            if (arr[p1_first_one_idx + i] != arr[p2_first_one_idx + i] ||
                arr[p1_first_one_idx + i] != arr[p3_first_one_idx + i]) {
                return {-1, -1};
            }
        }

        int i_split = p1_last_one_idx + num_trailing_zeros_p3;
        int j_split = p2_last_one_idx + num_trailing_zeros_p3;

        if (i_split + 1 <= p2_first_one_idx && j_split + 1 <= p3_first_one_idx) {
            return {i_split, j_split + 1};
        } else {
            return {-1, -1};
        }
    }
};