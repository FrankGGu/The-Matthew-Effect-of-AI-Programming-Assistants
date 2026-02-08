class Solution {
public:
    long long sum(int n, int index, int maxSum) {
        long long left = index;
        long long right = n - index - 1;
        long long res = 0;
        if (maxSum > left) {
            res += (maxSum + maxSum - left) * (left + 1) / 2;
        } else {
            res += (maxSum + maxSum - maxSum + left) * maxSum / 2;
        }
        if (maxSum > right) {
            res += (maxSum + maxSum - right) * (right + 1) / 2;
        } else {
            res += (maxSum + maxSum - maxSum + right) * maxSum / 2;
        }
        res -= maxSum;
        return res;
    }

    int maxValue(int n, int index, int maxSum) {
        int left = 1;
        int right = maxSum;
        int ans = 0;
        while (left <= right) {
            int mid = left + (right - left) / 2;
            if (sum(n, index, mid) <= maxSum) {
                ans = mid;
                left = mid + 1;
            } else {
                right = mid - 1;
            }
        }
        return ans;
    }
};