class Solution {
public:
    string smallestGoodBase(string n) {
        unsigned long long num = stoull(n);
        for (int m = log2(num) + 1; m >= 2; --m) {
            unsigned long long left = 2, right = pow(num, 1.0 / (m - 1)) + 1;
            while (left <= right) {
                unsigned long long mid = left + (right - left) / 2;
                unsigned long long sum = 1, curr = 1;
                for (int i = 1; i < m; ++i) {
                    curr *= mid;
                    sum += curr;
                }
                if (sum == num) {
                    return to_string(mid);
                } else if (sum < num) {
                    left = mid + 1;
                } else {
                    right = mid - 1;
                }
            }
        }
        return to_string(num - 1);
    }
};