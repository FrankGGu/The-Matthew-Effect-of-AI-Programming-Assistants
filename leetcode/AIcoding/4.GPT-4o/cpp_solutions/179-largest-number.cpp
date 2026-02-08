#include <vector>
#include <string>
#include <algorithm>

class Solution {
public:
    std::string largestNumber(std::vector<int>& nums) {
        std::vector<std::string> str_nums;
        for (int num : nums) {
            str_nums.push_back(std::to_string(num));
        }
        std::sort(str_nums.begin(), str_nums.end(), [](const std::string &a, const std::string &b) {
            return a + b > b + a;
        });
        if (str_nums[0] == "0") return "0";
        std::string result;
        for (const std::string &str : str_nums) {
            result += str;
        }
        return result;
    }
};