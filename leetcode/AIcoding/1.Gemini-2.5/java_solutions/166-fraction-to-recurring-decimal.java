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

        result.append(num / den);
        num %= den;

        if (num == 0) {
            return result.toString();
        }

        result.append(".");
        Map<Long, Integer> remainderMap = new HashMap<>();

        while (num != 0) {
            if (remainderMap.containsKey(num)) {
                int index = remainderMap.get(num);
                result.insert(index, "(");
                result.append(")");
                return result.toString();
            }

            remainderMap.put(num, result.length());
            num *= 10;
            result.append(num / den);
            num %= den;
        }

        return result.toString();
    }
}