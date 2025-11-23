#include <vector>
#include <random>

class Solution {
private:
    std::vector<int> original;
    std::vector<int> current;
    std::default_random_engine generator;

public:
    Solution(std::vector<int>& nums) : original(nums), current(nums) {
        generator.seed(std::random_device{}());
    }

    std::vector<int> reset() {
        current = original;
        return current;
    }

    std::vector<int> shuffle() {
        for (int i = current.size() - 1; i > 0; --i) {
            std::uniform_int_distribution<int> distribution(0, i);
            int j = distribution(generator);
            std::swap(current[i], current[j]);
        }
        return current;
    }
};