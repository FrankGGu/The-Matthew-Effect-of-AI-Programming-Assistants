#include <string>
#include <unordered_map>

using namespace std;

class Solution {
public:
    string fractionToDecimal(int numerator, int denominator) {
        if (numerator == 0) return "0";

        string result;
        if ((numerator < 0) ^ (denominator < 0)) result += "-";

        long num = labs((long)numerator);
        long den = labs((long)denominator);

        long quotient = num / den;
        result += to_string(quotient);

        long remainder = num % den;
        if (remainder == 0) return result;

        result += ".";
        unordered_map<long, int> remainderMap;

        while (remainder != 0) {
            if (remainderMap.count(remainder)) {
                result.insert(remainderMap[remainder], "(");
                result += ")";
                return result;
            }

            remainderMap[remainder] = result.size();
            remainder *= 10;
            quotient = remainder / den;
            result += to_string(quotient);
            remainder %= den;
        }

        return result;
    }
};