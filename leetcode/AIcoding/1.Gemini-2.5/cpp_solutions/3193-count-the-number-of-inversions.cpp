#include <vector>

class Solution {
public:
    long long mergeAndCount(std::vector<int>& arr, std::vector<int>& temp, int left, int mid, int right) {
        int i = left;
        int j = mid + 1;
        int k = left;
        long long inversions = 0;

        while (i <= mid && j <= right) {
            if (arr[i] <= arr[j]) {
                temp[k++] = arr[i++];
            } else {
                temp[k++] = arr[j++];
                inversions += (mid - i + 1);
            }
        }

        while (i <= mid) {
            temp[k++] = arr[i++];
        }

        while (j <= right) {
            temp[k++] = arr[j++];
        }

        for (int idx = left; idx <= right; ++idx) {
            arr[idx] = temp[idx];
        }

        return inversions;
    }

    long long mergeSortAndCount(std::vector<int>& arr, std::vector<int>& temp, int left, int right) {
        long long inversions = 0;
        if (left < right) {
            int mid = left + (right - left) / 2;

            inversions += mergeSortAndCount(arr, temp, left, mid);
            inversions += mergeSortAndCount(arr, temp, mid + 1, right);
            inversions += mergeAndCount(arr, temp, left, mid, right);
        }
        return inversions;
    }

    long long countInversions(std::vector<int>& nums) {
        int n = nums.size();
        if (n == 0) {
            return 0;
        }
        std::vector<int> temp(n);
        return mergeSortAndCount(nums, temp, 0, n - 1);
    }
};