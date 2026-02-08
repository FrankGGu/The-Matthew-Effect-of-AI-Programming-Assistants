#include <iostream>
#include <vector>
#include <unordered_map>

class Solution {
public:
    int sumOfUniqueElements(std::vector<int>& nums) {
        std::unordered_map<int, int> count;
        for (int num : nums) {
            count[num]++;
        }
        int sum = 0;
        for (const auto& pair : count) {
            if (pair.second == 1) {
                sum += pair.first;
            }
        }
        return sum;
    }
};