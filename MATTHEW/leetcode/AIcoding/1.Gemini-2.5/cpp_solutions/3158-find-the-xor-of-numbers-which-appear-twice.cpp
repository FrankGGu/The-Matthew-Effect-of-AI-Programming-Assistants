#include <vector>
#include <unordered_map>

class Solution {
public:
    int duplicateNumbersXOR(std::vector<int>& nums) {
        std::unordered_map<int, int> counts;
        for (int num : nums) {
            counts[num]++;
        }

        int xor_sum = 0;
        for (auto const& pair : counts) {
            if (pair.second == 2) {
                xor_sum ^= pair.first;
            }
        }
        return xor_sum;
    }
};