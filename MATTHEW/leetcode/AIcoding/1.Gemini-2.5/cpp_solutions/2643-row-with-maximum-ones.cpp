#include <vector>
#include <numeric>

class Solution {
public:
    std::vector<int> rowAndMaximumOnes(std::vector<std::vector<int>>& mat) {
        int max_index = 0;
        int max_count = 0;

        for (int i = 0; i < mat.size(); ++i) {
            int current_count = 0;
            for (int val : mat[i]) {
                current_count += val;
            }

            if (current_count > max_count) {
                max_count = current_count;
                max_index = i;
            }
        }

        return {max_index, max_count};
    }
};