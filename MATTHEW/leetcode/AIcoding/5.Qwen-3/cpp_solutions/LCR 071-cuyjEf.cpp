#include <iostream>
#include <vector>
#include <random>
#include <algorithm>

class Solution {
private:
    std::vector<int> prefixSums;
    std::mt19937 rng;

public:
    Solution(const std::vector<int>& w) : rng(std::random_device{}()) {
        prefixSums.resize(w.size());
        prefixSums[0] = w[0];
        for (int i = 1; i < w.size(); ++i) {
            prefixSums[i] = prefixSums[i - 1] + w[i];
        }
    }

    int pickIndex() {
        std::uniform_int_distribution<int> dist(1, prefixSums.back());
        int target = dist(rng);
        return std::lower_bound(prefixSums.begin(), prefixSums.end(), target) - prefixSums.begin();
    }
};