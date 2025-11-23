#include <vector>
#include <algorithm> // For std::shuffle
#include <random>    // For std::mt19937
#include <chrono>    // For seeding std::mt19937

class Solution {
private:
    std::vector<int> original_nums;
    std::mt19937 rng;

public:
    Solution(std::vector<int>& nums) : original_nums(nums) {
        rng.seed(std::chrono::steady_clock::now().time_since_epoch().count());
    }

    std::vector<int> reset() {
        return original_nums;
    }

    std::vector<int> shuffle() {
        std::vector<int> shuffled_array = original_nums;
        std::shuffle(shuffled_array.begin(), shuffled_array.end(), rng);
        return shuffled_array;
    }
};