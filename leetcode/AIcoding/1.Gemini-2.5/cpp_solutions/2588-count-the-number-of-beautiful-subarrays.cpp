#include <vector>
#include <unordered_map>

class Solution {
public:
    long long beautifulSubarrays(std::vector<int>& nums) {
        std::unordered_map<int, int> counts;
        counts[0] = 1;
        long long result = 0;
        int current_xor = 0;
        for (int num : nums) {
            current_xor ^= num;
            if (counts.count(current_xor)) {
                result += counts[current_xor];
            }
            counts[current_xor]++;
        }
        return result;
    }
};