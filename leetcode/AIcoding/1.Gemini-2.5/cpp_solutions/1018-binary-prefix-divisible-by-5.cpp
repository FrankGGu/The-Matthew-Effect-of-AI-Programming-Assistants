class Solution {
public:
    std::vector<bool> prefixesDivBy5(std::vector<int>& nums) {
        std::vector<bool> result;
        int current_remainder = 0;

        for (int num : nums) {
            current_remainder = (current_remainder * 2 + num) % 5;
            result.push_back(current_remainder == 0);
        }

        return result;
    }
};