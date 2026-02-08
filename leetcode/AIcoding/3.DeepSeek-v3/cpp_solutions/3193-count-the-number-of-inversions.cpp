#include <vector>
using namespace std;

class Solution {
public:
    int countInversions(vector<int>& nums) {
        vector<int> temp(nums.size());
        return mergeSort(nums, temp, 0, nums.size() - 1);
    }

private:
    int mergeSort(vector<int>& nums, vector<int>& temp, int left, int right) {
        if (left >= right) return 0;
        int mid = left + (right - left) / 2;
        int inv_count = mergeSort(nums, temp, left, mid);
        inv_count += mergeSort(nums, temp, mid + 1, right);
        inv_count += merge(nums, temp, left, mid, right);
        return inv_count;
    }

    int merge(vector<int>& nums, vector<int>& temp, int left, int mid, int right) {
        int i = left, j = mid + 1, k = left;
        int inv_count = 0;
        while (i <= mid && j <= right) {
            if (nums[i] <= nums[j]) {
                temp[k++] = nums[i++];
            } else {
                temp[k++] = nums[j++];
                inv_count += (mid - i + 1);
            }
        }
        while (i <= mid) {
            temp[k++] = nums[i++];
        }
        while (j <= right) {
            temp[k++] = nums[j++];
        }
        for (i = left; i <= right; ++i) {
            nums[i] = temp[i];
        }
        return inv_count;
    }
};