#include <vector>
#include <algorithm>

class Solution {
public:
    std::vector<int> sortedSquares(std::vector<int>& nums) {
        int n = nums.size();
        std::vector<int> result(n);
        int left = 0;
        int right = n - 1;
        int write_pointer = n - 1;

        while (left <= right) {
            int square_left = nums[left] * nums[left];
            int square_right = nums[right] * nums[right];

            if (square_left > square_right) {
                result[write_pointer] = square_left;
                left++;
            } else {
                result[write_pointer] = square_right;
                right--;
            }
            write_pointer--;
        }
        return result;
    }
};