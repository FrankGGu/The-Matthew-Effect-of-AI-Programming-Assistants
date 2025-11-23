#include <vector>
#include <numeric>
#include <random>

class Solution {
public:
    Solution(std::vector<int>& w) {
        totalWeight = std::accumulate(w.begin(), w.end(), 0);
        weights = w;
    }

    int pickIndex() {
        int randomValue = rand() % totalWeight;
        for (int i = 0; i < weights.size(); ++i) {
            randomValue -= weights[i];
            if (randomValue < 0) {
                return i;
            }
        }
        return -1; // should never reach here
    }

private:
    std::vector<int> weights;
    int totalWeight;
};