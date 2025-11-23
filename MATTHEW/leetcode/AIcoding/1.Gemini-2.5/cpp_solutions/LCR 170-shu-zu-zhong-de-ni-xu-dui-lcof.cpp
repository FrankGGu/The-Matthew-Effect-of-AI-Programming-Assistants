#include <vector>
#include <algorithm>

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
        count += merge(nums, low, mid, high);
        return count;
    }

    int merge(std::vector<int>& nums, int low, int mid, int high) {
        int count = 0;
        int j = mid + 1;

        // Count reverse pairs where nums[i] is from left half and nums[j] is from right half
        for (int i = low; i <= mid; ++i) {
            while (j <= high && (long long)nums[i] > 2 * (long long)nums[j]) {
                j++;
            }
            count += (j - (mid + 1));
        }

        // Standard merge sort step to sort the combined array
        std::vector<int> temp;
        int left_ptr = low;
        int right_ptr = mid + 1;

        while (left_ptr <= mid && right_ptr <= high) {
            if (nums[left_ptr] <= nums[right_ptr]) {
                temp.push_back(nums[left_ptr++]);
            } else {
                temp.push_back(nums[right_ptr++]);
            }
        }

        while (left_ptr <= mid) {
            temp.push_back(nums[left_ptr++]);
        }

        while (right_ptr <= high) {
            temp.push_back(nums[right_ptr++]);
        }

        for (int k = low; k <= high; ++k) {
            nums[k] = temp[k - low];
        }
        return count;
    }
};