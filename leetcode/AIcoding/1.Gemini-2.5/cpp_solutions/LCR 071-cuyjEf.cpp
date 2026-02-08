#include <vector>
#include <numeric>
#include <random>
#include <algorithm>

class Solution {
private:
    std::vector<int> prefix_sums;
    std::mt19937 gen;
    std::uniform_int_distribution<int> dist;

public:
    Solution(std::vector<int>& w) : gen(std::random_device{}()) {
        prefix_sums.reserve(w.size());
        int current_sum = 0;
        for (int weight : w) {
            current_sum += weight;
            prefix_sums.push_back(current_sum);
        }
        dist = std::uniform_int_distribution<int>(0, current_sum - 1);
    }

    int pickIndex() {
        int target = dist(gen);
        auto it = std::upper_bound(prefix_sums.begin(), prefix_sums.end(), target);
        return std::distance(prefix_sums.begin(), it);
    }
};