#include <vector>
#include <unordered_map>

class Solution {
public:
    int numSubarraysWithSum(std::vector<int>& nums, int goal) {
        int count = 0;
        int current_sum = 0;
        std::unordered_map<int, int> freq;
        freq[0] = 1;

        for (int num : nums) {
            current_sum += num;
            if (freq.count(current_sum - goal)) {
                count += freq[current_sum - goal];
            }
            freq[current_sum]++;
        }

        return count;
    }
};