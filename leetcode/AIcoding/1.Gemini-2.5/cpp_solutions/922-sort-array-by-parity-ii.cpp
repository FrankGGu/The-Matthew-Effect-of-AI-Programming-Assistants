#include <vector>
#include <algorithm> // Required for std::swap

class Solution {
public:
    std::vector<int> sortArrayByParityII(std::vector<int>& nums) {
        int n = nums.size();
        int j = 1; // Pointer for odd indices, starts at the first odd index

        // Iterate through even indices
        for (int i = 0; i < n; i += 2) {
            // If the number at the current even index is odd (misplaced)
            if (nums[i] % 2 != 0) {
                // Find an even number at an odd index 'j'
                // 'j' will only point to odd indices
                while (nums[j] % 2 != 0) {
                    j += 2;
                }
                // Swap the misplaced odd number at nums[i] with the misplaced even number at nums[j]
                std::swap(nums[i], nums[j]);
                // After the swap, nums[i] is even (correct) and nums[j] is odd (correct).
                // 'i' will advance to the next even index in the for loop.
                // 'j' retains its position and will continue searching from there if another swap is needed.
                // This ensures 'j' always points to an odd index where an even number might be misplaced.
            }
        }
        return nums;
    }
};