#include <vector>
#include <map>
#include <algorithm>

class Solution {
public:
    int findLucky(std::vector<int>& arr) {
        std::map<int, int> freq;
        for (int num : arr) {
            freq[num]++;
        }

        int maxLucky = -1;
        for (auto const& [val, count] : freq) {
            if (val == count) {
                maxLucky = std::max(maxLucky, val);
            }
        }

        return maxLucky;
    }
};