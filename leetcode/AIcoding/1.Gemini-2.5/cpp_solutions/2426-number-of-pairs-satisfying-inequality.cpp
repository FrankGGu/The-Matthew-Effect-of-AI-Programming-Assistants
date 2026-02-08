#include <vector>
#include <algorithm>

class Solution {
public:
    long long numberOfPairs(std::vector<int>& nums1, std::vector<int>& nums2, int diff) {
        int n = nums1.size();
        std::vector<int> d(n);
        for (int i = 0; i < n; ++i) {
            d[i] = nums1[i] - nums2[i];
        }
        return mergeSortAndCount(d, 0, n - 1, diff);
    }

private:
    long long mergeSortAndCount(std::vector<int>& nums, int left, int right, int diff) {
        if (left >= right) {
            return 0;
        }

        int mid = left + (right - left) / 2;
        long long count = 0;
        count += mergeSortAndCount(nums, left, mid, diff);
        count += mergeSortAndCount(nums, mid + 1, right, diff);

        int i = left;
        for (int j = mid + 1; j <= right; ++j) {
            while (i <= mid && nums[i] <= (long long)nums[j] + diff) {
                i++;
            }
            count += (i - left);
        }

        std::inplace_merge(nums.begin() + left, nums.begin() + mid + 1, nums.begin() + right + 1);

        return count;
    }
};