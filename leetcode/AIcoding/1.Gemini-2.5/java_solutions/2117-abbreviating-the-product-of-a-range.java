import java.math.BigInteger;

class Solution {

    // Modular multiplication (a * b) % m where a, b, m are long.
    // This function handles potential overflow of a * b before modulo.
    // It assumes m > 0.
    private long mulMod(long a, long b, long m) {
        long res = 0;
        a %= m;
        while (b > 0) {
            if ((b & 1) != 0) { // If b is odd, add a to result
                res = (res + a);
                if (res >= m) res -= m; // Ensure res stays < m
            }
            a = (a << 1); // a = a * 2
            if (a >= m) a -= m; // Ensure a stays < m
            b >>= 1; // b = b / 2
        }
        return res;
    }

    public String abbreviateProduct(int left, int right) {
        long totalTwos = 0;
        long totalFives = 0;
        double logProduct = 0.0; // To track total digits using log10
        long actualSuffix = 1; // To track suffix, modulo a large number
        // SUFFIX_MODULO is 10^18, the maximum value a long can hold without overflow
        // when performing (a * b) % m with a, b < m.
        // It ensures we retain enough digits for the suffix calculation.
        long SUFFIX_MODULO = 1_000_000_000_000_000_000L; 

        for (long i = left; i <= right; ++i) {
            logProduct += Math.log10(i);

            long temp = i;
            while (temp > 0 && temp % 2 == 0) {
                totalTwos++;
                temp /= 2;
            }
            while (temp > 0 && temp % 5 == 0) {
                totalFives++;
                temp /= 5;
            }
            actualSuffix = mulMod(actualSuffix, temp, SUFFIX_MODULO);
        }

        int trailingZerosCount = (int) Math.min(totalTwos, totalFives);

        // Adjust suffix by multiplying remaining 2s and 5s
        long remainingTwos = totalTwos - trailingZerosCount;
        long remainingFives = totalFives - trailingZerosCount;

        for (int k = 0; k < remainingTwos; ++k) {
            actualSuffix = mulMod(actualSuffix, 2, SUFFIX_MODULO);
        }
        for (int k = 0; k < remainingFives; ++k) {
            actualSuffix = mulMod(actualSuffix, 5, SUFFIX_MODULO);
        }

        long totalDigits = (long) Math.floor(logProduct) + 1;

        // Case 1: Product has 10 or fewer digits
        if (totalDigits <= 10) {
            // Calculate the exact product using BigInteger to avoid overflow,
            // even if it would fit in a long, for consistency.
            BigInteger directProduct = BigInteger.ONE;
            for (int i = left; i <= right; ++i) {
                directProduct = directProduct.multiply(BigInteger.valueOf(i));
            }
            return directProduct.toString();
        }

        // Case 2: Product has more than 10 digits. Abbreviation needed.

        // Prefix calculation:
        // The actual product P has `totalDigits` digits.
        // P = 10^(logProduct)
        // The first 5 digits are `floor(10^(logProduct - (totalDigits - 5)))`.
        long prefixValue = (long) Math.pow(10, logProduct - (totalDigits - 5));
        String prefixStr = String.valueOf(prefixValue);
        if (prefixStr.length() > 5) { // Handle potential floating point inaccuracies leading to 6 digits
            prefixStr = prefixStr.substring(0, 5);
        }

        // Suffix calculation:
        // `actualSuffix` now holds `(P / 10^trailingZerosCount) % SUFFIX_MODULO`.
        // We need the last 5 digits of `P / 10^trailingZerosCount`.
        String suffixStr;
        long numDigitsWithoutTrailingZeros = totalDigits - trailingZerosCount;

        if (numDigitsWithoutTrailingZeros <= 5) {
            // The number without trailing zeros has <= 5 digits. Use its value directly.
            // In this case, `actualSuffix` will be the exact value of `P / 10^trailingZerosCount`
            // because it's small enough not to be affected by `SUFFIX_MODULO`.
            suffixStr = String.valueOf(actualSuffix);
        } else {
            // The number without trailing zeros has > 5 digits. Take the last 5 digits.
            // `actualSuffix` contains the last `k` digits of `P / 10^T`, where `k` is at least 18 (due to SUFFIX_MODULO).
            // So `String.valueOf(actualSuffix)` will give a string with at least 18 digits (potentially with leading zeros if actualSuffix is small).
            // We just need to take the last 5 characters of this string.
            String suffixRawStr = String.valueOf(actualSuffix);
            suffixStr = suffixRawStr.substring(suffixRawStr.length() - 5);
        }

        return prefixStr + "..." + suffixStr + "e" + trailingZerosCount;
    }
}