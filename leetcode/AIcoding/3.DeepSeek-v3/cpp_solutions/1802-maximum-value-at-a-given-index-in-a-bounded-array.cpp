class Solution {
public:
    int maxValue(int n, int index, int maxSum) {
        int left = 1, right = maxSum;
        while (left < right) {
            int mid = (left + right + 1) / 2;
            if (valid(mid, n, index, maxSum)) {
                left = mid;
            } else {
                right = mid - 1;
            }
        }
        return left;
    }

private:
    bool valid(int mid, int n, int index, int maxSum) {
        long sum = 0;
        int left = index;
        int right = n - index - 1;

        sum += calc(mid, left) + calc(mid, right) + mid;
        sum -= mid; // subtract the duplicated mid

        return sum <= maxSum;
    }

    long calc(int mid, int len) {
        if (len < mid - 1) {
            return (long)(mid - 1 + mid - len) * len / 2;
        } else {
            return (long)(mid - 1 + 1) * (mid - 1) / 2 + (len - (mid - 1));
        }
    }
};