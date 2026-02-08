#include <vector>
#include <unordered_map>
#include <algorithm>

class Solution {
public:
    int maxOperations(std::vector<int>& nums, int k) {
        std::unordered_map<int, int> freq;
        int count = 0;
        for (int num : nums) {
            int complement = k - num;
            if (freq.count(complement) && freq[complement] > 0) {
                count++;
                freq[complement]--;
            } else {
                freq[num]++;
            }
        }
        return count;
    }
};