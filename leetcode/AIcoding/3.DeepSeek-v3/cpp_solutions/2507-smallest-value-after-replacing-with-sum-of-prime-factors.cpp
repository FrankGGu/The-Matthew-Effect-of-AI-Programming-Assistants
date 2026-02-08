class Solution {
public:
    int smallestValue(int n) {
        while (true) {
            int sum = 0;
            int original = n;
            for (int i = 2; i <= n; ++i) {
                while (n % i == 0) {
                    sum += i;
                    n /= i;
                }
            }
            if (sum == original) {
                return sum;
            }
            n = sum;
        }
    }
};