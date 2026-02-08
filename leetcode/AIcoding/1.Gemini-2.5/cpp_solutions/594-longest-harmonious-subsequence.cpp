#include <vector>
#include <unordered_map>
#include <algorithm>

class Solution {
public:
    int findLHS(std::vector<int>& nums) {
        std::unordered_map<int, int> freq;
        for (int num : nums) {
            freq[num]++;
        }

        int maxLen = 0;
        for (auto const& [num, count] : freq) {
            if (freq.count(num + 1)) {
                maxLen = std::max(maxLen, count + freq[num + 1]);
            }
        }
        return maxLen;
    }
};