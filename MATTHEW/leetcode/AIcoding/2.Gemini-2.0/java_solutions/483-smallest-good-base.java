class Solution {
    public String smallestGoodBase(long n) {
        long m = (long) (Math.log(n) / Math.log(2));
        for (long i = m; i >= 1; i--) {
            long k = (long) Math.pow(n, 1.0 / i);
            if (k <= 1) continue;
            long sum = 1, p = 1;
            for (int j = 1; j <= i; j++) {
                if (n / k < p) {
                    sum = n + 1;
                    break;
                }
                p *= k;
                sum += p;
            }
            if (sum == n) {
                return String.valueOf(k);
            }
        }
        return String.valueOf(n - 1);
    }
}