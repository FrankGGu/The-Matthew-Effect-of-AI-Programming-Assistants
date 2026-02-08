#include <vector>
#include <algorithm>
#include <unordered_map>

class Solution {
public:
    int deleteAndEarn(std::vector<int>& nums) {
        std::unordered_map<int, int> points;
        for (int num : nums) {
            points[num] += num;
        }

        std::vector<int> unique_nums;
        for (const auto& pair : points) {
            unique_nums.push_back(pair.first);
        }

        std::sort(unique_nums.begin(), unique_nums.end());

        int prev = -1, earn1 = 0, earn2 = 0;
        for (int num : unique_nums) {
            if (num - 1 == prev) {
                int temp = earn2;
                earn2 = std::max(earn2, earn1 + points[num]);
                earn1 = temp;
            } else {
                int temp = earn2;
                earn2 += points[num];
                earn1 = temp;
            }
            prev = num;
        }

        return earn2;
    }
};