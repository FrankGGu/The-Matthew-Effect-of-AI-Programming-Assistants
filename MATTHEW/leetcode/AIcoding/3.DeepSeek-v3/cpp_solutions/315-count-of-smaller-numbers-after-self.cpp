#include <vector>
#include <algorithm>

using namespace std;

class Solution {
private:
    void mergeSort(vector<pair<int, int>>& nums, vector<pair<int, int>>& temp, int left, int right, vector<int>& res) {
        if (left >= right) return;
        int mid = left + (right - left) / 2;
        mergeSort(nums, temp, left, mid, res);
        mergeSort(nums, temp, mid + 1, right, res);
        merge(nums, temp, left, mid, right, res);
    }

    void merge(vector<pair<int, int>>& nums, vector<pair<int, int>>& temp, int left, int mid, int right, vector<int>& res) {
        int i = left, j = mid + 1, k = left;
        int count = 0;
        while (i <= mid && j <= right) {
            if (nums[i].first > nums[j].first) {
                count++;
                temp[k++] = nums[j++];
            } else {
                res[nums[i].second] += count;
                temp[k++] = nums[i++];
            }
        }
        while (i <= mid) {
            res[nums[i].second] += count;
            temp[k++] = nums[i++];
        }
        while (j <= right) {
            temp[k++] = nums[j++];
        }
        for (int idx = left; idx <= right; idx++) {
            nums[idx] = temp[idx];
        }
    }

public:
    vector<int> countSmaller(vector<int>& nums) {
        int n = nums.size();
        vector<int> res(n, 0);
        vector<pair<int, int>> indexedNums;
        for (int i = 0; i < n; i++) {
            indexedNums.emplace_back(nums[i], i);
        }
        vector<pair<int, int>> temp(n);
        mergeSort(indexedNums, temp, 0, n - 1, res);
        return res;
    }
};