#include <iostream>
#include <vector>
#include <string>
#include <cmath>

using namespace std;

class Solution {
public:
    string fractionToDecimal(int numerator, int denominator) {
        if (numerator == 0) return "0";

        string result;

        if ((numerator < 0) ^ (denominator < 0)) {
            result += "-";
        }

        long long num = labs(static_cast<long long>(numerator));
        long long den = labs(static_cast<long long>(denominator));

        result += to_string(num / den);

        num %= den;

        if (num == 0) {
            return result;
        }

        result += ".";

        unordered_map<long long, int> map;
        while (num != 0) {
            if (map.find(num) != map.end()) {
                result.insert(map[num], "(");
                result += ")";
                break;
            }
            map[num] = result.size();
            num *= 10;
            result += to_string(num / den);
            num %= den;
        }

        return result;
    }
};