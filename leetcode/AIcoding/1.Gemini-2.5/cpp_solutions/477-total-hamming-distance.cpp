#include <vector>

class Solution {
public:
    int totalHammingDistance(std::vector<int>& nums) {
        int n = nums.size();
        int total_distance = 0;

        for (int i = 0; i < 32; ++i) {
            int count_ones = 0;
            for (int num : nums) {
                if ((num >> i) & 1) {
                    count_ones++;
                }
            }
            int count_zeros = n - count_ones;
            total_distance += count_ones * count_zeros;
        }

        return total_distance;
    }
};