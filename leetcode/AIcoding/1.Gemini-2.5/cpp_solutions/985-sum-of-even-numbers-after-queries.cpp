#include <vector>
#include <numeric>

class Solution {
public:
    std::vector<int> sumEvenAfterQueries(std::vector<int>& nums, std::vector<std::vector<int>>& queries) {
        long long current_even_sum = 0;
        for (int num : nums) {
            if (num % 2 == 0) {
                current_even_sum += num;
            }
        }

        std::vector<int> result;
        result.reserve(queries.size());

        for (const auto& query : queries) {
            int val = query[0];
            int index = query[1];

            int old_val = nums[index];

            if (old_val % 2 == 0) {
                current_even_sum -= old_val;
            }

            nums[index] += val;
            int new_val = nums[index];

            if (new_val % 2 == 0) {
                current_even_sum += new_val;
            }
            result.push_back(current_even_sum);
        }

        return result;
    }
};