#include <vector>

class Solution {
public:
    std::vector<int> pivotArray(std::vector<int>& nums, int pivot) {
        std::vector<int> result(nums.size());
        int k = 0;

        for (int num : nums) {
            if (num < pivot) {
                result[k++] = num;
            }
        }

        for (int num : nums) {
            if (num == pivot) {
                result[k++] = num;
            }
        }

        for (int num : nums) {
            if (num > pivot) {
                result[k++] = num;
            }
        }

        return result;
    }
};