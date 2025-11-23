import java.util.HashMap;
import java.util.Map;

class Solution {
    public String fractionToDecimal(int numerator, int denominator) {
        if (numerator == 0) {
            return "0";
        }

        StringBuilder result = new StringBuilder();
        if ((numerator < 0) ^ (denominator < 0)) {
            result.append("-");
        }

        long num = Math.abs((long) numerator);
        long den = Math.abs((long) denominator);

        long quotient = num / den;
        long remainder = num % den;

        result.append(quotient);

        if (remainder == 0) {
            return result.toString();
        }

        result.append(".");
        Map<Long, Integer> remainderMap = new HashMap<>();

        while (remainder != 0) {
            if (remainderMap.containsKey(remainder)) {
                int index = remainderMap.get(remainder);
                result.insert(index, "(");
                result.append(")");
                return result.toString();
            }

            remainderMap.put(remainder, result.length());
            remainder *= 10;
            quotient = remainder / den;
            remainder %= den;
            result.append(quotient);
        }

        return result.toString();
    }
}