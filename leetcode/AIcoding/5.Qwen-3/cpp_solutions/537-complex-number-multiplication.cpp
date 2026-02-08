#include <iostream>
#include <vector>
#include <sstream>
#include <string>

using namespace std;

class Solution {
public:
    string complexNumberMultiply(string a, string b) {
        int real1, imag1, real2, imag2;
        char ch;
        stringstream ss(a);
        ss >> real1 >> ch >> imag1 >> ch;
        ss.clear();
        ss.str(b);
        ss >> real2 >> ch >> imag2 >> ch;

        int real = real1 * real2 - imag1 * imag2;
        int imag = real1 * imag2 + imag1 * real2;

        return to_string(real) + "+" + to_string(imag) + "i";
    }
};