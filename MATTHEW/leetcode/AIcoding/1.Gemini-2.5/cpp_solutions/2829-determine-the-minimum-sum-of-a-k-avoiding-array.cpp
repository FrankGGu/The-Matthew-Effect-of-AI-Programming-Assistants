class Solution {
public:
    int minimumSum(int n, int k) {
        long long m = k / 2;
        long long sum = 0;
        if ((long long)n <= m) {
            sum = (long long)n * (n + 1) / 2;
        } else {
            sum = m * (m + 1) / 2;
            long long remaining_count = n - m;
            long long first = k;
            long long last = k + remaining_count - 1;
            sum += remaining_count * (first + last) / 2;
        }
        return (int)sum;
    }
};