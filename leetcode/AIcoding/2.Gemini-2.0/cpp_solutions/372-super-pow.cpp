class Solution {
public:
    int superPow(int a, vector<int>& b) {
        int res = 1;
        a %= 1337;
        for (int i = 0; i < b.size(); ++i) {
            res = powMod(res, 10) * powMod(a, b[i]) % 1337;
        }
        return res;
    }

private:
    int powMod(int x, int n) {
        int res = 1;
        x %= 1337;
        while (n > 0) {
            if (n % 2 == 1) {
                res = (res * x) % 1337;
            }
            x = (x * x) % 1337;
            n /= 2;
        }
        return res;
    }
};