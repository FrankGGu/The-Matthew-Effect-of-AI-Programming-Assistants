class Solution {
public:
    int maxValue(int n, int index, int maxSum) {
        int left = 1, right = maxSum;
        int ans = 0;
        while (left <= right) {
            int mid = left + (right - left) / 2;
            long long sum = mid;
            if (index > 0) {
                sum += sumRange(mid - 1, index);
            } else {
                sum += mid-1 > 0 ? mid - 1 : 0;
            }
            if (n - index - 1 > 0) {
                sum += sumRange(mid - 1, n - index - 1);
            } else {
                sum += mid-1 > 0 ? mid - 1 : 0;
            }
            if (sum <= maxSum) {
                ans = mid;
                left = mid + 1;
            } else {
                right = mid - 1;
            }
        }
        return ans;
    }

private:
    long long sumRange(int peak, int length) {
        if (length >= peak) {
            return (long long)peak * (peak - 1) / 2 + length - peak + 1;
        } else {
            return (long long)(peak + peak - length + 1) * length / 2;
        }
    }
};