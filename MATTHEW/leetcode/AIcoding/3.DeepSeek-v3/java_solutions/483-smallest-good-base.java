class Solution {
    public String smallestGoodBase(String n) {
        long num = Long.parseLong(n);
        long maxM = (long)(Math.log(num + 1) / Math.log(2));
        for (long m = maxM; m >= 2; m--) {
            long k = (long)Math.pow(num, 1.0 / m);
            if (k < 2) continue;
            long sum = 0;
            long current = 1;
            for (long i = 0; i <= m; i++) {
                sum += current;
                if (sum > num) break;
                current *= k;
            }
            if (sum == num) {
                return String.valueOf(k);
            }
        }
        return String.valueOf(num - 1);
    }
}