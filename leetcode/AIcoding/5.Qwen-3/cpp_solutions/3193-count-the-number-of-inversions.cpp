#include <iostream>
#include <vector>

using namespace std;

class Solution {
public:
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

        for (i = left; i <= right; i++) {
            nums[i] = temp[i];
        }

        return inv_count;
    }

    int mergeSort(vector<int>& nums, vector<int>& temp, int left, int right) {
        int inv_count = 0;
        if (left < right) {
            int mid = (left + right) / 2;
            inv_count += mergeSort(nums, temp, left, mid);
            inv_count += mergeSort(nums, temp, mid + 1, right);
            inv_count += merge(nums, temp, left, mid, right);
        }
        return inv_count;
    }

    int countInversions(vector<int>& nums) {
        int n = nums.size();
        vector<int> temp(n);
        return mergeSort(nums, temp, 0, n - 1);
    }
};