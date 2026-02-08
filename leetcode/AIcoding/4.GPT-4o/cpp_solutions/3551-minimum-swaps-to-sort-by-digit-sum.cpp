#include <vector>
#include <algorithm>
#include <numeric>

class Solution {
public:
    int minimumSwaps(std::vector<int>& nums) {
        int n = nums.size();
        std::vector<int> sorted_nums = nums;
        std::sort(sorted_nums.begin(), sorted_nums.end());
        std::vector<int> visited(n, 0);
        int swaps = 0;

        for (int i = 0; i < n; i++) {
            if (visited[i] || nums[i] == sorted_nums[i]) {
                continue;
            }

            int cycle_size = 0;
            int j = i;

            while (!visited[j]) {
                visited[j] = 1;
                j = std::find(nums.begin(), nums.end(), sorted_nums[j]) - nums.begin();
                cycle_size++;
            }

            if (cycle_size > 0) {
                swaps += (cycle_size - 1);
            }
        }
        return swaps;
    }
};