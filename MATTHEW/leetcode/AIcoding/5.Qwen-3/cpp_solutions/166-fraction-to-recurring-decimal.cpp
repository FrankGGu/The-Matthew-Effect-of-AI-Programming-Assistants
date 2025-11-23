#include <iostream>
#include <vector>
#include <string>
#include <unordered_map>

using namespace std;

class Solution {
public:
    string fractionToDecimal(int numerator, int denominator) {
        if (numerator == 0) return "0";

        string result;

                if ((numerator < 0) ^ (denominator < 0)) {
            result += "-";
        }

        long long n = abs((long long)numerator);
        long long d = abs((long long)denominator);

                result += to_string(n / d);
        n %= d;

        if (n == 0) {
            return result;
        }

                result += ".";
        unordered_map<long long, int> map;
        while (n != 0) {
            if (map.find(n) != map.end()) {
                                result.insert(map[n], "(");
                result += ")";
                break;
            }
            map[n] = result.size();
            n *= 10;
            result += to_string(n / d);
            n %= d;
        }

        return result;
    }
};