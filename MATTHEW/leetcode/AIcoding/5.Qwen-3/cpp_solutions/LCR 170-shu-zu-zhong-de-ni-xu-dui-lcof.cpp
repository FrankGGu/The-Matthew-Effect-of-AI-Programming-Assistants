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
        return count + merge(nums, left, mid, right);
    }

    int merge(vector<int>& nums, int left, int mid, int right) {
        vector<int> temp(right - left + 1);
        int i = left;
        int j = mid + 1;
        int k = 0;
        int count = 0;

        while (i <= mid && j <= right) {
            if (nums[i] > nums[j]) {
                temp[k++] = nums[j++];
                count += mid - i + 1;
            } else {
                temp[k++] = nums[i++];
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