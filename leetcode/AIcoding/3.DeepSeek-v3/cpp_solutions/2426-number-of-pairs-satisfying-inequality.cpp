#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    long long numberOfPairs(vector<int>& nums1, vector<int>& nums2, int diff) {
        int n = nums1.size();
        vector<int> nums(n);
        for (int i = 0; i < n; ++i) {
            nums[i] = nums1[i] - nums2[i];
        }

        vector<int> sorted_nums = nums;
        long long res = 0;
        vector<int> temp(n);
        mergeSort(nums, sorted_nums, temp, 0, n - 1, diff, res);
        return res;
    }

private:
    void mergeSort(vector<int>& nums, vector<int>& sorted_nums, vector<int>& temp, int left, int right, int diff, long long& res) {
        if (left >= right) return;
        int mid = left + (right - left) / 2;
        mergeSort(nums, sorted_nums, temp, left, mid, diff, res);
        mergeSort(nums, sorted_nums, temp, mid + 1, right, diff, res);

        int i = left, j = mid + 1;
        while (i <= mid && j <= right) {
            if (nums[i] <= nums[j] + diff) {
                res += right - j + 1;
                i++;
            } else {
                j++;
            }
        }

        i = left, j = mid + 1;
        int k = left;
        while (i <= mid && j <= right) {
            if (sorted_nums[i] <= sorted_nums[j]) {
                temp[k++] = sorted_nums[i++];
            } else {
                temp[k++] = sorted_nums[j++];
            }
        }
        while (i <= mid) temp[k++] = sorted_nums[i++];
        while (j <= right) temp[k++] = sorted_nums[j++];

        for (int idx = left; idx <= right; ++idx) {
            sorted_nums[idx] = temp[idx];
        }
    }
};