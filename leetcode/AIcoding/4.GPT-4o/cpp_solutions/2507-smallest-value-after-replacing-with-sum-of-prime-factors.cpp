class Solution {
public:
    int smallestValue(int n) {
        while (true) {
            int sum = 0;
            int tmp = n;
            for (int i = 2; i * i <= tmp; ++i) {
                while (tmp % i == 0) {
                    sum += i;
                    tmp /= i;
                }
            }
            if (tmp > 1) sum += tmp;
            if (sum == n) break;
            n = sum;
        }
        return n;
    }
};