#include <vector>
#include <string>
#include <algorithm>
#include <utility>

class Solution {
public:
    int getJumbledValue(int num, const std::vector<int>& mapping) {
        if (num == 0) {
            return mapping[0];
        }

        long long jumbled_num = 0;
        long long place_value = 1;
        int temp_num = num;

        while (temp_num > 0) {
            int digit = temp_num % 10;
            int mapped_digit = mapping[digit];
            jumbled_num = mapped_digit * place_value + jumbled_num;
            place_value *= 10;
            temp_num /= 10;
        }
        return static_cast<int>(jumbled_num);
    }

    std::vector<int> sortJumbled(std::vector<int>& mapping, std::vector<int>& nums) {
        std::vector<std::pair<int, int>> jumbled_pairs;

        for (int i = 0; i < nums.size(); ++i) {
            int original_num = nums[i];
            int jumbled_val = getJumbledValue(original_num, mapping);
            jumbled_pairs.push_back({jumbled_val, i});
        }

        std::stable_sort(jumbled_pairs.begin(), jumbled_pairs.end(), 
                         [](const std::pair<int, int>& a, const std::pair<int, int>& b) {
                             return a.first < b.first;
                         });

        std::vector<int> result;
        result.reserve(nums.size());

        for (const auto& p : jumbled_pairs) {
            result.push_back(nums[p.second]);
        }

        return result;
    }
};