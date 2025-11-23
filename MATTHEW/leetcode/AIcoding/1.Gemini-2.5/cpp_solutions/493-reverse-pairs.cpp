#include <vector>
#include <algorithm> // Required for std::inplace_merge

class Solution {
public:
    int reversePairs(std::vector<int>& nums) {
        return mergeSortAndCount(nums, 0, nums.size() - 1);
    }

private:
    int mergeSortAndCount(std::vector<int>& nums, int low, int high) {
        if (low >= high) {
            return 0;
        }

        int mid = low + (high - low) / 2;
        int count = mergeSortAndCount(nums, low, mid);
        count += mergeSortAndCount(nums, mid + 1, high);

        // Count reverse pairs across the two halves
        // Left half: nums[low...mid]
        // Right half: nums[mid+1...high]
        int j = mid + 1;
        for (int i = low; i <= mid; ++i) {
            while (j <= high && (long long)nums[i] > 2LL * nums[j]) {
                j++;
            }
            // All elements from nums[mid+1] to nums[j-1] form a reverse pair with nums[i]
            count += (j - (mid + 1));
        }

        // Merge the two sorted halves
        // std::inplace_merge merges two consecutive sorted ranges [first, middle) and [middle, last)
        // into one sorted range [first, last).
        std::inplace_merge(nums.begin() + low, nums.begin() + mid + 1, nums.begin() + high + 1);

        return count;
    }
};