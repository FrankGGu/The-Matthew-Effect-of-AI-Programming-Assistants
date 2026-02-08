#include <vector>
#include <unordered_map>
#include <algorithm>

class Solution {
public:
    int findShortestSubArray(std::vector<int>& nums) {
        std::unordered_map<int, int> counts;
        std::unordered_map<int, int> first_occurrence;
        std::unordered_map<int, int> last_occurrence;

        for (int i = 0; i < nums.size(); ++i) {
            int num = nums[i];
            counts[num]++;
            if (first_occurrence.find(num) == first_occurrence.end()) {
                first_occurrence[num] = i;
            }
            last_occurrence[num] = i;
        }

        int max_degree = 0;
        for (auto const& [num, count] : counts) {
            if (count > max_degree) {
                max_degree = count;
            }
        }

        int min_length = nums.size(); // Initialize with maximum possible length

        for (auto const& [num, count] : counts) {
            if (count == max_degree) {
                int current_length = last_occurrence[num] - first_occurrence[num] + 1;
                if (current_length < min_length) {
                    min_length = current_length;
                }
            }
        }

        return min_length;
    }
};