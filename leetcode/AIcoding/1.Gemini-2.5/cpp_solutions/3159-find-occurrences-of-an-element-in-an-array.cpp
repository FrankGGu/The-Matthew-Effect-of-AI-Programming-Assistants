#include <vector>
#include <numeric>

class Solution {
public:
    std::vector<int> occurrencesOfElement(std::vector<int>& nums, std::vector<int>& queries, int x) {
        std::vector<int> x_indices;
        for (int i = 0; i < nums.size(); ++i) {
            if (nums[i] == x) {
                x_indices.push_back(i);
            }
        }

        std::vector<int> results;
        results.reserve(queries.size());

        for (int q : queries) {
            if (q > 0 && q <= x_indices.size()) {
                results.push_back(x_indices[q - 1]);
            } else {
                results.push_back(-1);
            }
        }

        return results;
    }
};