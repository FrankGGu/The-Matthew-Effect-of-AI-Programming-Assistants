#include <string>

using namespace std;

class Solution {
public:
    string complexNumberMultiply(string num1, string num2) {
        int a1, b1, a2, b2;
        size_t plusPos1 = num1.find('+');
        size_t iPos1 = num1.find('i');
        a1 = stoi(num1.substr(0, plusPos1));
        b1 = stoi(num1.substr(plusPos1 + 1, iPos1 - plusPos1 - 1));

        size_t plusPos2 = num2.find('+');
        size_t iPos2 = num2.find('i');
        a2 = stoi(num2.substr(0, plusPos2));
        b2 = stoi(num2.substr(plusPos2 + 1, iPos2 - plusPos2 - 1));

        int real = a1 * a2 - b1 * b2;
        int imaginary = a1 * b2 + a2 * b1;

        return to_string(real) + "+" + to_string(imaginary) + "i";
    }
};