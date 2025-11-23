class Solution {
    public String abbreviateProduct(int left, int right) {
        double product = 1.0;
        long trailingZeros = 0;
        long mod = 1;
        for (int i = left; i <= right; i++) {
            int num = i;
            while (num % 2 == 0) {
                num /= 2;
                trailingZeros++;
            }
            while (num % 5 == 0) {
                num /= 5;
                trailingZeros++;
            }
            product *= num;
            mod *= num;
            if (mod > 1000000000000L) {
                mod %= 1000000000000L;
            }
            while (product > 1e11) {
                product /= 10;
            }
        }
        String suffix = String.valueOf(mod % 100000);
        while (suffix.length() < 5) {
            suffix = "0" + suffix;
        }
        String prefix = String.valueOf((long) product).substring(0, Math.min(10, String.valueOf((long) product).length()));
        return prefix + "..." + suffix + "e" + trailingZeros;
    }
}