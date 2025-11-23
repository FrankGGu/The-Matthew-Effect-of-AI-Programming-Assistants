class Solution {
public:
    int maxValue(int n, int index, int maxSum) {
        int left = max(0, index);
        int right = max(0, n - index - 1);
        int low = 1, high = maxSum;

        while (low < high) {
            int mid = low + (high - low + 1) / 2;
            long long total = mid + calculateSum(mid - 1, left) + calculateSum(mid - 1, right);
            if (total <= maxSum) {
                low = mid;
            } else {
                high = mid - 1;
            }
        }
        return low;
    }

private:
    long long calculateSum(int x, int length) {
        if (length <= x) return (long long)length * (length + 1) / 2;
        return (long long)x * (x + 1) / 2 + (length - x);
    }
};