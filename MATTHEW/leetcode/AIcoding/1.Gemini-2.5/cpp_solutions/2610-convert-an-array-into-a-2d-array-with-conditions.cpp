#include <vector>
#include <algorithm> // Required for std::max

class Solution {
public:
    std::vector<std::vector<int>> findMatrix(std::vector<int>& nums) {
        std::vector<int> counts(201, 0); // nums[i] are between 1 and 200
        int max_freq = 0;

        // Count frequencies of each number and find the maximum frequency
        for (int num : nums) {
            counts[num]++;
            if (counts[num] > max_freq) {
                max_freq = counts[num];
            }
        }

        // Initialize the 2D array with `max_freq` empty rows
        std::vector<std::vector<int>> ans(max_freq);

        // Populate the 2D array
        // For each number 'num' (from 1 to 200)
        // if it appeared 'count' times, add it to the first 'count' rows
        for (int num = 1; num <= 200; ++num) {
            for (int i = 0; i < counts[num]; ++i) {
                ans[i].push_back(num);
            }
        }

        return ans;
    }
};