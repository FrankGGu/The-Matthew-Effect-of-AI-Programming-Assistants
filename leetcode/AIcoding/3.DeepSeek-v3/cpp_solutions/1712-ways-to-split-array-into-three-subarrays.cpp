class Solution {
public:
    int waysToSplit(vector<int>& nums) {
        int n = nums.size();
        vector<int> prefix(n, 0);
        prefix[0] = nums[0];
        for (int i = 1; i < n; ++i) {
            prefix[i] = prefix[i-1] + nums[i];
        }

        int res = 0;
        int mod = 1e9 + 7;

        for (int i = 0; i < n - 2; ++i) {
            int left = prefix[i];
            int low = i + 1, high = n - 2;
            int leftBound = -1, rightBound = -1;

            while (low <= high) {
                int mid = low + (high - low) / 2;
                int midSum = prefix[mid] - left;
                int rightSum = prefix[n-1] - prefix[mid];
                if (midSum >= left && rightSum >= midSum) {
                    leftBound = mid;
                    high = mid - 1;
                } else if (midSum < left) {
                    low = mid + 1;
                } else {
                    high = mid - 1;
                }
            }

            low = i + 1, high = n - 2;
            while (low <= high) {
                int mid = low + (high - low) / 2;
                int midSum = prefix[mid] - left;
                int rightSum = prefix[n-1] - prefix[mid];
                if (midSum >= left && rightSum >= midSum) {
                    rightBound = mid;
                    low = mid + 1;
                } else if (midSum < left) {
                    low = mid + 1;
                } else {
                    high = mid - 1;
                }
            }

            if (leftBound != -1 && rightBound != -1) {
                res = (res + (rightBound - leftBound + 1)) % mod;
            }
        }

        return res;
    }
};