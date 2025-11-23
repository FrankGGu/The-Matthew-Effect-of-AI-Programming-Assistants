#include <vector>
#include <unordered_map>
#include <algorithm>

class Solution {
public:
    int findMaxLength(std::vector<int>& nums) {
        std::unordered_map<int, int> count_map;
        count_map[0] = -1;
        int max_len = 0;
        int count = 0;
        for (int i = 0; i < nums.size(); ++i) {
            count += (nums[i] == 1 ? 1 : -1);
            if (count_map.count(count)) {
                max_len = std::max(max_len, i - count_map[count]);
            } else {
                count_map[count] = i;
            }
        }
        return max_len;
    }
};