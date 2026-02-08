#include <iostream>
#include <vector>
#include <algorithm>
#include <numeric>

class Solution {
public:
    double trimMean(std::vector<int>& arr) {
        int n = arr.size();
        int remove = n * 0.2;
        std::sort(arr.begin(), arr.end());
        double sum = std::accumulate(arr.begin() + remove, arr.end() - remove, 0);
        return static_cast<double>(sum) / (n - 2 * remove);
    }
};