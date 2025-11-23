class Solution {
public:
    int smallestMissingValue(std::vector<int>& nums) {
        std::sort(nums.begin(), nums.end());
        int expected = 1;
        for (int num : nums) {
            if (num == expected) {
                expected++;
            }
        }
        return expected;
    }
};