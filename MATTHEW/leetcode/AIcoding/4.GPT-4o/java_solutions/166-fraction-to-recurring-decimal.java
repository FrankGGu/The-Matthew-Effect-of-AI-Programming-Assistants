import java.util.HashMap;

public class Solution {
    public String fractionToDecimal(int numerator, int denominator) {
        if (numerator == 0) return "0";
        StringBuilder result = new StringBuilder();
        if ((numerator < 0) ^ (denominator < 0)) result.append("-");
        long num = Math.abs((long) numerator);
        long den = Math.abs((long) denominator);
        result.append(num / den);
        num %= den;
        if (num == 0) return result.toString();
        result.append(".");
        HashMap<Long, Integer> map = new HashMap<>();
        map.put(num, result.length());
        while (num != 0) {
            num *= 10;
            result.append(num / den);
            num %= den;
            if (map.containsKey(num)) {
                result.insert(map.get(num), "(");
                result.append(")");
                break;
            }
            map.put(num, result.length());
        }
        return result.toString();
    }
}