#include <iostream>
#include <vector>
#include <unordered_map>
#include <algorithm>

class Solution {
public:
    int countAlmostEqualPairs(const std::vector<int>& nums) {
        int count = 0;
        std::unordered_map<int, int> freq;
        for (int num : nums) {
            ++freq[num];
        }
        for (const auto& [num, cnt] : freq) {
            for (int i = 0; i < 10; ++i) {
                int diff = 1 << i;
                int target = num + diff;
                if (freq.find(target) != freq.end()) {
                    count += cnt * freq[target];
                }
                target = num - diff;
                if (target >= 0 && freq.find(target) != freq.end()) {
                    count += cnt * freq[target];
                }
            }
        }
        return count / 2;
    }
};