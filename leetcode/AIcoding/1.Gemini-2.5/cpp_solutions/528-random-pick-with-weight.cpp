#include <vector>
#include <numeric>
#include <algorithm>
#include <random>
#include <chrono>

class Solution {
private:
    std::vector<int> prefix_sums;
    std::mt19937 gen;
    std::uniform_int_distribution<int> dist;

public:
    Solution(std::vector<int>& w) 
        : gen(std::chrono::high_resolution_clock::now().time_since_epoch().count()) {

        prefix_sums.reserve(w.size());
        int current_sum = 0;
        for (int weight : w) {
            current_sum += weight;
            prefix_sums.push_back(current_sum);
        }
        dist = std::uniform_int_distribution<int>(1, current_sum);
    }

    int pickIndex() {
        int target = dist(gen);

        auto it = std::lower_bound(prefix_sums.begin(), prefix_sums.end(), target);

        return std::distance(prefix_sums.begin(), it);
    }
};