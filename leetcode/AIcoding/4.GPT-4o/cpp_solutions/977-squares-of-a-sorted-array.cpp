#include <vector>
#include <algorithm>

std::vector<int> sortedSquares(std::vector<int>& nums) {
    for (int& num : nums) {
        num *= num;
    }
    std::sort(nums.begin(), nums.end());
    return nums;
}