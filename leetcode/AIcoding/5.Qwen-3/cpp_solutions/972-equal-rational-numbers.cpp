#include <iostream>
#include <vector>
#include <string>
#include <sstream>
#include <cmath>

using namespace std;

class Solution {
public:
    bool isRationalEqual(string s, string t) {
        auto parse = [](const string& str) {
            istringstream iss(str);
            double val;
            iss >> val;
            return val;
        };

        return abs(parse(s) - parse(t)) < 1e-9;
    }
};