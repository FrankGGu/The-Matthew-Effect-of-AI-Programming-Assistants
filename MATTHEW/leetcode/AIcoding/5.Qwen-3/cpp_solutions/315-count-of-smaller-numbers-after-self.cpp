#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    vector<int> countSmaller(vector<int>& nums) {
        vector<int> result(nums.size(), 0);
        vector<pair<int, int>> indexedNums;
        for (int i = 0; i < nums.size(); ++i) {
            indexedNums.push_back({nums[i], i});
        }
        mergeSort(indexedNums, 0, nums.size() - 1, result);
        return result;
    }

private:
    void mergeSort(vector<pair<int, int>>& nums, int left, int right, vector<int>& result) {
        if (left >= right) return;
        int mid = left + (right - left) / 2;
        mergeSort(nums, left, mid, result);
        mergeSort(nums, mid + 1, right, result);
        merge(nums, left, mid, right, result);
    }

    void merge(vector<pair<int, int>>& nums, int left, int mid, int right, vector<int>& result) {
        vector<pair<int, int>> temp(right - left + 1);
        int i = left, j = mid + 1, k = 0;
        while (i <= mid && j <= right) {
            if (nums[i].first <= nums[j].first) {
                temp[k++] = nums[i++];
            } else {
                temp[k++] = nums[j++];
                for (int m = left; m <= mid; ++m) {
                    result[nums[m].second]++;
                }
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
    }
};