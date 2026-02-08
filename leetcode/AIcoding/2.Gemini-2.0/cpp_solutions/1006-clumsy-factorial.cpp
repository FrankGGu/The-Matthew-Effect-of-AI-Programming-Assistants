class Solution {
public:
    int clumsy(int n) {
        if (n == 1) return 1;
        if (n == 2) return 2;
        if (n == 3) return 6;
        int res = n * (n - 1) / (n - 2);
        n -= 3;
        int sign = 1;
        while (n > 0) {
            res += sign * n;
            n--;
            if (n > 0) {
                res -= sign * (n * (n - 1) / (n > 2 ? (n - 2) : 1));
                n -= 3;
            }
            sign = -1;
        }
        return res;
    }
};