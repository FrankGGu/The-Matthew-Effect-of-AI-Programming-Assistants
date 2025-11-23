#include <vector>
#include <unordered_map>
#include <algorithm>

class Solution {
public:
    int countMaxFrequency(std::vector<int>& nums) {
        std::unordered_map<int, int> freq;
        int maxFreq = 0;

        for (int num : nums) {
            maxFreq = std::max(maxFreq, ++freq[num]);
        }

        int count = 0;
        for (const auto& pair : freq) {
            if (pair.second == maxFreq) {
                count++;
            }
        }

        return count;
    }
};