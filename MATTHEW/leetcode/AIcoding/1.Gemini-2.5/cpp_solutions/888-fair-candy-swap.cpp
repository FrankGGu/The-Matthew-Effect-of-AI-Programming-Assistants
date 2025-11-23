#include <vector>
#include <numeric>
#include <unordered_set>

class Solution {
public:
    std::vector<int> fairCandySwap(std::vector<int>& aliceSizes, std_vector<int>& bobSizes) {
        long long sumA = 0;
        for (int size : aliceSizes) {
            sumA += size;
        }

        long long sumB = 0;
        std::unordered_set<int> bobCandies;
        for (int size : bobSizes) {
            sumB += size;
            bobCandies.insert(size);
        }

        long long diff = (sumA - sumB) / 2;

        for (int x : aliceSizes) {
            int y = x - diff;
            if (bobCandies.count(y)) {
                return {x, y};
            }
        }
        return {}; 
    }
};