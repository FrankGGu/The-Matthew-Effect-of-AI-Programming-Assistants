import java.math.BigInteger;

public class Solution {
    public String smallestGoodBase(String n) {
        BigInteger num = new BigInteger(n);
        for (int m = 59; m >= 2; m--) {
            BigInteger k = BigInteger.valueOf((long) Math.pow(2, m)) - 1;
            BigInteger base = k.divide(num);
            if (base.compareTo(BigInteger.ZERO) > 0) {
                BigInteger sum = BigInteger.ZERO;
                BigInteger current = BigInteger.ONE;
                for (int i = 0; i < m; i++) {
                    sum = sum.add(current);
                    current = current.multiply(base);
                }
                if (sum.compareTo(num) == 0) {
                    return base.add(BigInteger.ONE).toString();
                }
            }
        }
        return num.subtract(BigInteger.ONE).toString();
    }
}