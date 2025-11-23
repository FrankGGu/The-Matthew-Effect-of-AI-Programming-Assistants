class Solution {
public:
    int countWays(int n, int x) {
        return countWaysUtil(n, x, 1);
    }

private:
    int countWaysUtil(int n, int x, int cur) {
        int power = pow(cur, x);
        if (power > n) return 0;
        if (power == n) return 1;
        return countWaysUtil(n - power, x, cur + 1) + countWaysUtil(n, x, cur + 1);
    }
};