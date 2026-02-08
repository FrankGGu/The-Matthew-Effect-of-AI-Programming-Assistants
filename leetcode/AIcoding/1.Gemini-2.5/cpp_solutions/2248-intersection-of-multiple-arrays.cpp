#include <vector>
#include <numeric> // Not strictly needed for this solution, but often useful with vectors

class Solution {
public:
    std::vector<int> intersection(std::vector<std::vector<int>>& nums) {
        std::vector<int> counts(1001, 0); // Max value for nums[i][j] is 1000

        for (const auto& arr : nums) {
            for (int num : arr) {
                counts[num]++;
            }
        }

        std::vector<int> result;
        int numArrays = nums.size();

        for (int i = 1; i <= 1000; ++i) {
            if (counts[i] == numArrays) {
                result.push_back(i);
            }
        }

        return result;
    }
};