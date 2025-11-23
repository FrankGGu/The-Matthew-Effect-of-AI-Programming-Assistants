public class Solution {

import java.util.*;

public class DeepDarkFraction {
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

        Map<Long, Integer> map = new HashMap<>();
        while (num != 0) {
            num *= 10;
            if (map.containsKey(num)) {
                result.insert(map.get(num), "(");
                result.append(")");
                break;
            }
            map.put(num, result.length());
            result.append(num / den);
            num %= den;
        }

        return result.toString();
    }
}
}