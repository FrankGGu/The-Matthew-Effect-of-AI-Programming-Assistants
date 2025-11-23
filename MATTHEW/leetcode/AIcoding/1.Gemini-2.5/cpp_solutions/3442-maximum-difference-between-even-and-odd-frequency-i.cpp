#include <vector>
#include <cmath> // Required for std::abs

class Solution {
public:
    int maxDifference(std::vector<int>& nums) {
        int even_frequency = 0;
        int odd_frequency = 0;

        for (int num : nums) {
            if (num % 2 == 0) {
                even_frequency++;
            } else {
                odd_frequency++;
            }
        }

        return std::abs(even_frequency - odd_frequency);
    }
};