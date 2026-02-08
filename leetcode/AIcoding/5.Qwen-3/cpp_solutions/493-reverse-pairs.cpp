#include <iostream>
#include <vector>

using namespace std;

class Solution {
public:
    int reversePairs(vector<int>& nums) {
        return mergeSort(nums, 0, nums.size() - 1);
    }

private:
    int mergeSort(vector<int>& nums, int left, int right) {
        if (left >= right) return 0;
        int mid = left + (right - left) / 2;
        int count = mergeSort(nums, left, mid) + mergeSort(nums, mid + 1, right);
        count += merge(nums, left, mid, right);
        return count;
    }

    int merge(vector<int>& nums, int left, int mid, int right) {
        int i = left, j = mid + 1, k = 0;
        int count = 0;
        vector<int> temp(right - left + 1);

        while (i <= mid && j <= right) {
            if (nums[i] <= nums[j]) {
                temp[k++] = nums[i++];
            } else {
                count += mid - i + 1;
                temp[k++] = nums[j++];
            }
        }

        while (i <= mid) {
            temp[k++] = nums[i++];
        }

        while (j <= right) {
            temp[k++] = nums[j++];
        }

        for (int m = 0; m < k; ++m) {
            nums[left + m] = temp[m];
        }

        return count;
    }
};