#include <iostream>
#include <vector>
#include <sstream>
#include <cmath>

using namespace std;

class Solution {
public:
    string fractionAddition(string expression) {
        vector<int> numerators;
        vector<int> denominators;

        int sign = 1;
        int num = 0;
        int den = 0;
        bool isNum = true;

        for (int i = 0; i < expression.size(); ++i) {
            if (expression[i] == '+') {
                if (isNum) {
                    numerators.push_back(sign * num);
                    num = 0;
                    isNum = false;
                }
                sign = 1;
            } else if (expression[i] == '-') {
                if (isNum) {
                    numerators.push_back(sign * num);
                    num = 0;
                    isNum = false;
                }
                sign = -1;
            } else if (expression[i] == '/') {
                isNum = false;
                den = 0;
            } else if (isdigit(expression[i])) {
                if (isNum) {
                    num = num * 10 + (expression[i] - '0');
                } else {
                    den = den * 10 + (expression[i] - '0');
                }
            }
        }

        if (isNum) {
            numerators.push_back(sign * num);
        } else {
            denominators.push_back(den);
        }

        for (int i = 0; i < numerators.size(); ++i) {
            denominators.push_back(1);
        }

        for (int i = 0; i < numerators.size(); ++i) {
            int a = numerators[i];
            int b = denominators[i];
            int c = numerators[i + 1];
            int d = denominators[i + 1];

            int new_num = a * d + c * b;
            int new_den = b * d;

            int gcd_val = gcd(new_num, new_den);
            new_num /= gcd_val;
            new_den /= gcd_val;

            numerators[i + 1] = new_num;
            denominators[i + 1] = new_den;
        }

        return to_string(numerators.back()) + "/" + to_string(denominators.back());
    }

private:
    int gcd(int a, int b) {
        while (b != 0) {
            int temp = b;
            b = a % b;
            a = temp;
        }
        return a;
    }
};