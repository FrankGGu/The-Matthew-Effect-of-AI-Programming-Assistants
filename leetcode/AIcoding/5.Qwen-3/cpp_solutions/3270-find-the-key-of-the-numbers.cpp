#include <iostream>
#include <vector>
#include <unordered_map>

class Solution {
public:
    int findKey(const std::vector<int>& numbers) {
        std::unordered_map<int, int> countMap;
        for (int num : numbers) {
            countMap[num]++;
        }
        for (const auto& pair : countMap) {
            if (pair.second == 1) {
                return pair.first;
            }
        }
        return -1;
    }
};