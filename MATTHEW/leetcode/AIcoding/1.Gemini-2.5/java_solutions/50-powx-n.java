class Solution {
    public double myPow(double x, int n) {
        long N = n;

        if (N < 0) {
            x = 1 / x;
            N = -N;
        }

        double ans = 1.0;
        double currentProduct = x;

        while (N > 0) {
            if (N % 2 == 1) {
                ans = ans * currentProduct;
            }
            currentProduct = currentProduct * currentProduct;
            N = N / 2;
        }

        return ans;
    }
}