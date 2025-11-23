#include <vector>

using namespace std;

class Solution {
public:
    long long reversePairs(vector<int>& nums) {
        int n = nums.size();
        vector<int> temp(n);
        return mergeSort(nums, temp, 0, n - 1);
    }

private:
    long long mergeSort(vector<int>& nums, vector<int>& temp, int left, int right) {
        if (left >= right) {
            return 0;
        }
        int mid = left + (right - left) / 2;
        long long count = mergeSort(nums, temp, left, mid) + mergeSort(nums, temp, mid + 1, right);
        int i = left, j = mid + 1, k = left;
        while (i <= mid && j <= right) {
            if ((long long)nums[i] > 2LL * nums[j]) {
                count += (mid - i + 1);
                j++;
            } else {
                i++;
            }
        }
        i = left, j = mid + 1, k = left;
        while (i <= mid && j <= right) {
            if (nums[i] <= nums[j]) {
                temp[k++] = nums[i++];
            } else {
                temp[k++] = nums[j++];
            }
        }
        while (i <= mid) {
            temp[k++] = nums[i++];
        }
        while (j <= right) {
            temp[k++] = nums[j++];
        }
        for (int i = left; i <= right; i++) {
            nums[i] = temp[i];
        }
        return count;
    }
};