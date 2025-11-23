#include <iostream>
#include <vector>
#include <unordered_map>

class Solution {
public:
    int maxFrequencyElements(const std::vector<int>& nums) {
        std::unordered_map<int, int> freq;
        int maxFreq = 0;
        for (int num : nums) {
            freq[num]++;
            if (freq[num] > maxFreq) {
                maxFreq = freq[num];
            }
        }
        int count = 0;
        for (const auto& pair : freq) {
            if (pair.second == maxFreq) {
                count += maxFreq;
            }
        }
        return count;
    }
};