class Solution {
public:
    int minOperations(vector<int>& nums, int k) {
        sort(nums.begin(), nums.end());
        int n = nums.size();
        int left = 0, right = n - 1, operations = 0;

        while (left <= right) {
            int median = nums[(left + right) / 2];
            if (median < k) {
                operations += k - median;
                left++;
            } else if (median > k) {
                operations += median - k;
                right--;
            } else {
                break;
            }
        }
        return operations;
    }
};