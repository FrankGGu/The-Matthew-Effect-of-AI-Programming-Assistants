class Solution {
public:
    int waysToSplit(vector<int>& nums) {
        int n = nums.size();
        vector<long long> prefix(n + 1, 0);
        for (int i = 0; i < n; ++i) {
            prefix[i + 1] = prefix[i] + nums[i];
        }
        int count = 0;
        for (int j = 1; j < n - 1; ++j) {
            long long leftSum = prefix[j];
            int low = j + 1, high = n - 1;
            while (low <= high) {
                int mid = low + (high - low) / 2;
                long long rightSum = prefix[n] - prefix[mid];
                if (leftSum > rightSum) {
                    high = mid - 1;
                } else {
                    low = mid + 1;
                }
            }
            int leftCount = low - (j + 1);
            low = j + 1, high = n - 1;
            while (low <= high) {
                int mid = low + (high - low) / 2;
                long long midSum = prefix[mid] - prefix[j];
                if (leftSum < midSum) {
                    high = mid - 1;
                } else {
                    low = mid + 1;
                }
            }
            int rightCount = (n - 1) - high;
            count += leftCount > 0 ? leftCount * rightCount : 0;
        }
        return count;
    }
};