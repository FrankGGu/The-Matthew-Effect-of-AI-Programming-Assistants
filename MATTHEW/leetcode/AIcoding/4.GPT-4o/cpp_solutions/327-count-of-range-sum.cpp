class Solution {
public:
    int countRangeSum(vector<int>& nums, int lower, int upper) {
        int n = nums.size();
        vector<long> prefix(n + 1, 0);
        for (int i = 0; i < n; ++i) {
            prefix[i + 1] = prefix[i] + nums[i];
        }
        return mergeSort(prefix, 0, n, lower, upper);
    }

private:
    int mergeSort(vector<long>& prefix, int left, int right, int lower, int upper) {
        if (left >= right) return 0;
        int mid = left + (right - left) / 2;
        int count = mergeSort(prefix, left, mid, lower, upper) + mergeSort(prefix, mid + 1, right, lower, upper);
        int j = mid + 1, k = mid + 1;
        for (int i = left; i <= mid; ++i) {
            while (j <= right && prefix[j] - prefix[i] < lower) j++;
            while (k <= right && prefix[k] - prefix[i] <= upper) k++;
            count += k - j;
        }
        inplace_merge(prefix.begin() + left, prefix.begin() + mid + 1, prefix.begin() + right + 1);
        return count;
    }
};