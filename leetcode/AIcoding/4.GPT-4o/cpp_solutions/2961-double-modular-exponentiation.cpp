class Solution {
public:
    int modExp(int a, int b, int m) {
        long long res = 1, base = a % m;
        while (b > 0) {
            if (b % 2 == 1) {
                res = (res * base) % m;
            }
            base = (base * base) % m;
            b /= 2;
        }
        return res;
    }

    int superPow(int a, vector<int>& b) {
        int m = 1337;
        int n = b.size();
        int exp = 0;
        for (int i = 0; i < n; ++i) {
            exp = (exp * 10 + b[i]) % (m - 1);
        }
        return modExp(a % m, exp, m);
    }
};