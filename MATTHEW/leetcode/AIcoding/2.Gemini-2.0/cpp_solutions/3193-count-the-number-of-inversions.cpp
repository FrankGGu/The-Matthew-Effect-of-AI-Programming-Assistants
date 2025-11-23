#include <vector>

using namespace std;

class Solution {
public:
    int reversePairs(vector<int>& nums) {
        return mergeSortAndCount(nums, 0, nums.size() - 1);
    }

private:
    int mergeSortAndCount(vector<int>& nums, int left, int right) {
        if (left >= right) {
            return 0;
        }

        int mid = left + (right - left) / 2;
        int count = mergeSortAndCount(nums, left, mid) + mergeSortAndCount(nums, mid + 1, right);

        int j = mid + 1;
        for (int i = left; i <= mid; i++) {
            while (j <= right && (long long)nums[i] > 2 * (long long)nums[j]) {
                j++;
            }
            count += (j - (mid + 1));
        }

        vector<int> merged;
        int i = left, k = mid + 1;
        while (i <= mid && k <= right) {
            if (nums[i] <= nums[k]) {
                merged.push_back(nums[i++]);
            } else {
                merged.push_back(nums[k++]);
            }
        }

        while (i <= mid) {
            merged.push_back(nums[i++]);
        }

        while (k <= right) {
            merged.push_back(nums[k++]);
        }

        for (int i = 0; i < merged.size(); i++) {
            nums[left + i] = merged[i];
        }

        return count;
    }
};