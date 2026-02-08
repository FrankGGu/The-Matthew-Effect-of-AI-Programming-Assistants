#include <iostream>
#include <vector>
#include <unordered_map>

class Solution {
public:
    int numberOfPairs(std::vector<std::string>& nums, std::string& target) {
        std::unordered_map<std::string, int> count;
        int result = 0;

        for (const auto& num : nums) {
            count[num]++;
        }

        for (const auto& num : nums) {
            std::string complement = target.substr(num.size());
            if (complement.size() == target.size() - num.size()) {
                if (count.find(complement) != count.end()) {
                    if (num != complement) {
                        result += count[complement];
                    } else {
                        result += count[num] - 1;
                    }
                }
            }
        }

        return result / 2;
    }
};