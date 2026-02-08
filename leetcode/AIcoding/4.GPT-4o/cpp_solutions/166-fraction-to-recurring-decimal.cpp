class Solution {
public:
    string fractionToDecimal(int numerator, int denominator) {
        if (numerator == 0) return "0";
        string result;
        if ((numerator < 0) ^ (denominator < 0)) result += "-";
        long num = abs((long)numerator);
        long den = abs((long)denominator);
        result += to_string(num / den);
        long remainder = num % den;
        if (remainder == 0) return result;
        result += ".";
        unordered_map<long, int> map;
        while (remainder != 0) {
            if (map.count(remainder)) {
                result.insert(map[remainder], "(");
                result += ")";
                break;
            }
            map[remainder] = result.size();
            remainder *= 10;
            result += to_string(remainder / den);
            remainder %= den;
        }
        return result;
    }
};