#include <iostream>
#include <vector>
#include <numeric>

using namespace std;

class Solution {
public:
    vector<string> simplifiedFractions(int n) {
        vector<string> result;
        for (int denominator = 2; denominator <= n; ++denominator) {
            for (int numerator = 1; numerator < denominator; ++numerator) {
                if (gcd(numerator, denominator) == 1) {
                    result.push_back(to_string(numerator) + "/" + to_string(denominator));
                }
            }
        }
        return result;
    }
};