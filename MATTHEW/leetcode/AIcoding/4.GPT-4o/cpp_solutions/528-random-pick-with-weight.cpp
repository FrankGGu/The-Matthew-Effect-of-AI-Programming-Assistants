#include <vector>
#include <numeric>
#include <random>

class Solution {
public:
    Solution(std::vector<int>& w) {
        totalWeight = std::accumulate(w.begin(), w.end(), 0);
        weights = std::move(w);
    }

    int pickIndex() {
        int target = rand() % totalWeight;
        for (int i = 0; i < weights.size(); i++) {
            if (target < weights[i]) {
                return i;
            }
            target -= weights[i];
        }
        return -1; // This line should never be reached
    }

private:
    std::vector<int> weights;
    int totalWeight;
};