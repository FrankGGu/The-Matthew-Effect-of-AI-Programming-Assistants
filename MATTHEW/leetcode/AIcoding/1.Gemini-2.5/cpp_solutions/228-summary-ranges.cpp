#include <vector>
#include <string>
#include <algorithm>

class Solution {
public:
    std::vector<std::string> summaryRanges(std::vector<int>& nums) {
        std::vector<std::string> result;
        if (nums.empty()) {
            return result;
        }

        int n = nums.size();
        int i = 0;
        while (i < n) {
            int start = nums[i];
            int j = i + 1;
            while (j < n && nums[j] == nums[j - 1] + 1) {
                j++;
            }
            int end = nums[j - 1];

            if (start == end) {
                result.push_back(std::to_string(start));
            } else {
                result.push_back(std::to_string(start) + "->" + std::to_string(end));
            }
            i = j;
        }
        return result;
    }
};