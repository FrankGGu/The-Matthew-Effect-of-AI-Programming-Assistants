#include <vector>
#include <numeric>

class NumArray {
private:
    std::vector<int> prefixSums;

public:
    NumArray(std::vector<int>& nums) {
        prefixSums.resize(nums.size() + 1, 0);
        for (int i = 0; i < nums.size(); ++i) {
            prefixSums[i + 1] = prefixSums[i] + nums[i];
        }
    }

    int sumRange(int left, int right) {
        return prefixSums[right + 1] - prefixSums[left];
    }
};