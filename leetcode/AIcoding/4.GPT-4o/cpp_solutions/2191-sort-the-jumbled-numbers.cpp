#include <vector>
#include <algorithm>

class Solution {
public:
    std::vector<int> sortJumbled(std::vector<int>& mapping, std::vector<int>& nums) {
        std::vector<std::pair<int, int>> mappedNums;

        for (int num : nums) {
            int mappedValue = 0, multiplier = 1;
            if (num == 0) {
                mappedValue = mapping[0];
            } else {
                while (num > 0) {
                    int digit = num % 10;
                    mappedValue += mapping[digit] * multiplier;
                    num /= 10;
                    multiplier *= 10;
                }
            }
            mappedNums.push_back({mappedValue, num});
        }

        std::sort(mappedNums.begin(), mappedNums.end());

        std::vector<int> result;
        for (auto& pair : mappedNums) {
            result.push_back(pair.second);
        }
        return result;
    }
};