#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int countRangeSum(vector<int>& nums, int lower, int upper) {
        vector<long> prefix(1, 0);
        for (int num : nums) {
            prefix.push_back(prefix.back() + num);
        }
        return mergeSort(prefix, 0, prefix.size() - 1, lower, upper);
    }

private:
    int mergeSort(vector<long>& prefix, int left, int right, int lower, int upper) {
        if (left >= right) return 0;
        int mid = left + (right - left) / 2;
        int count = mergeSort(prefix, left, mid, lower, upper) + mergeSort(prefix, mid + 1, right, lower, upper);
        int j = mid + 1, k = mid + 1;
        for (int i = left; i <= mid; ++i) {
            while (j <= right && prefix[j] - prefix[i] < lower) ++j;
            while (k <= right && prefix[k] - prefix[i] <= upper) ++k;
            count += (k - j);
        }
        merge(prefix, left, mid, right);
        return count;
    }

    void merge(vector<long>& prefix, int left, int mid, int right) {
        vector<long> temp(right - left + 1);
        int i = left, j = mid + 1, k = 0;
        while (i <= mid && j <= right) {
            if (prefix[i] <= prefix[j]) {
                temp[k++] = prefix[i++];
            } else {
                temp[k++] = prefix[j++];
            }
        }
        while (i <= mid) temp[k++] = prefix[i++];
        while (j <= right) temp[k++] = prefix[j++];
        for (int p = 0; p < k; ++p) {
            prefix[left + p] = temp[p];
        }
    }
};