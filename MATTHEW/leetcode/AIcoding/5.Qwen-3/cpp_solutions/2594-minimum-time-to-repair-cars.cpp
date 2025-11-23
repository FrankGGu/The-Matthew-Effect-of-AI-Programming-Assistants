#include <iostream>
#include <vector>
#include <numeric>
#include <algorithm>

class Solution {
public:
    long long repairCars(std::vector<int>& ranks, int time) {
        auto canRepair = [&](long long t) {
            long long total = 0;
            for (int r : ranks) {
                total += static_cast<long long>(t) / r;
                if (total >= static_cast<long long>(ranks.size())) {
                    return true;
                }
            }
            return false;
        };

        long long left = 0;
        long long right = *std::max_element(ranks.begin(), ranks.end()) * static_cast<long long>(ranks.size());

        while (left < right) {
            long long mid = left + (right - left) / 2;
            if (canRepair(mid)) {
                right = mid;
            } else {
                left = mid + 1;
            }
        }

        return left;
    }
};