#include <vector>
#include <unordered_map>
#include <algorithm>

class Solution {
public:
    int mostFrequentEven(std::vector<int>& nums) {
        std::unordered_map<int, int> freq;
        for (int num : nums) {
            if (num % 2 == 0) {
                freq[num]++;
            }
        }

        int maxFreq = 0;
        int result = -1;
        for (const auto& [num, count] : freq) {
            if (count > maxFreq || (count == maxFreq && num > result)) {
                maxFreq = count;
                result = num;
            }
        }

        return result;
    }
};