#include <vector>
#include <numeric>

class Solution {
public:
    long long cutBamboo(std::vector<int>& bamboo_len) {
        long long total_energy = 0;
        for (int len : bamboo_len) {
            if (len > 1) {
                total_energy += len;
            }
        }
        return total_energy;
    }
};