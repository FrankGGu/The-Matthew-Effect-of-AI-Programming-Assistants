#include <vector>

using namespace std;

class Solution {
public:
    int totalHammingDistance(vector<int>& nums) {
        int n = nums.size();
        int total_distance = 0;

        for (int i = 0; i < 32; ++i) {
            int count_zeros = 0;
            int count_ones = 0;
            for (int num : nums) {
                if ((num >> i) & 1) {
                    count_ones++;
                } else {
                    count_zeros++;
                }
            }
            total_distance += count_zeros * count_ones;
        }

        return total_distance;
    }
};