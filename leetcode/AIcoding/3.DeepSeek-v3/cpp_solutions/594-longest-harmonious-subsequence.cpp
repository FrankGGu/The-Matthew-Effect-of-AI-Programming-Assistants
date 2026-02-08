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

        int max_len = 0;
        for (auto it = freq.begin(); it != freq.end(); ++it) {
            int num = it->first;
            if (freq.find(num + 1) != freq.end()) {
                max_len = std::max(max_len, it->second + freq[num + 1]);
            }
        }

        return max_len;
    }
};