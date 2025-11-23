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
        int invCount = mergeSort(nums, temp, left, mid);
        invCount += mergeSort(nums, temp, mid + 1, right);
        invCount += merge(nums, temp, left, mid, right);
        return invCount;
    }

    int merge(vector<int>& nums, vector<int>& temp, int left, int mid, int right) {
        for (int i = left; i <= right; i++) {
            temp[i] = nums[i];
        }
        int i = left, j = mid + 1, k = left;
        int invCount = 0;

        while (i <= mid && j <= right) {
            if (temp[i] <= temp[j]) {
                nums[k++] = temp[i++];
            } else {
                nums[k++] = temp[j++];
                invCount += (mid - i + 1);
            }
        }

        while (i <= mid) {
            nums[k++] = temp[i++];
        }

        while (j <= right) {
            nums[k++] = temp[j++];
        }

        return invCount;
    }
};