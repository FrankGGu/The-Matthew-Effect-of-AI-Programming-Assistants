class Solution {
    public String deepDarkFraction(int numerator, int denominator) {
        if (numerator == 0) return "0";
        if (denominator == 0) return "undefined";

        StringBuilder result = new StringBuilder();

        if ((numerator < 0) ^ (denominator < 0)) result.append("-");

        long num = Math.abs((long) numerator);
        long denom = Math.abs((long) denominator);

        result.append(num / denom);
        num %= denom;

        if (num == 0) return result.toString();

        result.append(".");

        Map<Long, Integer> map = new HashMap<>();
        while (num != 0) {
            if (map.containsKey(num)) {
                int index = map.get(num);
                result.insert(index, "(");
                result.append(")");
                return result.toString();
            }
            map.put(num, result.length());
            num *= 10;
            result.append(num / denom);
            num %= denom;
        }

        return result.toString();
    }
}