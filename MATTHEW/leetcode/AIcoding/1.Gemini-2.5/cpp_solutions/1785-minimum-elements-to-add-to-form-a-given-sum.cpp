#include <vector>
#include <numeric>
#include <cmath>

class Solution {
public:
    long long minElements(std::vector<int>& nums, int limit, int goal) {
        long long current_sum = std::accumulate(nums.begin(), nums.end(), 0LL);

        long long diff = goal - current_sum;

        long long abs_diff = std::abs(diff);

        long long num_elements = (abs_diff + limit - 1) / limit;

        return num_elements;
    }
};