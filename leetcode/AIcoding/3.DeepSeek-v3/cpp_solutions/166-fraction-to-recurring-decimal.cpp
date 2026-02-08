class Solution {
public:
    string fractionToDecimal(int numerator, int denominator) {
        if (numerator == 0) return "0";

        string res;
        if (numerator < 0 ^ denominator < 0) {
            res += '-';
        }

        long num = labs(numerator);
        long den = labs(denominator);

        res += to_string(num / den);
        long rem = num % den;
        if (rem == 0) {
            return res;
        }

        res += '.';
        unordered_map<long, int> rem_pos;
        while (rem != 0) {
            if (rem_pos.find(rem) != rem_pos.end()) {
                res.insert(rem_pos[rem], "(");
                res += ')';
                break;
            }
            rem_pos[rem] = res.size();
            rem *= 10;
            res += to_string(rem / den);
            rem %= den;
        }
        return res;
    }
};