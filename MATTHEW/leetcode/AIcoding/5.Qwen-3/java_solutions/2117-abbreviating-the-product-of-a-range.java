public class Solution {
    public String abbreviateProduct(String lower, String upper) {
        long left = Long.parseLong(lower);
        long right = Long.parseLong(upper);
        long product = 1;
        long count = 0;
        long mod = 1;
        for (long i = left; i <= right; i++) {
            product *= i;
            if (product > 10000000000L) {
                product /= 10;
                count++;
            }
            mod = (mod * i) % 10000000000L;
        }
        while (product >= 10000000000L) {
            product /= 10;
            count++;
        }
        while (count > 0) {
            mod /= 10;
            count--;
        }
        return String.format("%dE%d", product, mod);
    }
}