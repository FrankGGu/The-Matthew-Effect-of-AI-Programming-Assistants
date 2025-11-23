#include <iostream>
#include <vector>
#include <string>

using namespace std;

class Solution {
public:
    vector<string> splitIntoMinDeciBinaryNumbers(string n) {
        vector<string> result;
        int maxDigit = 0;
        for (char c : n) {
            maxDigit = max(maxDigit, c - '0');
        }
        for (int i = 0; i < maxDigit; ++i) {
            string s;
            for (char c : n) {
                if (c - '0' > i) {
                    s += '1';
                } else {
                    s += '0';
                }
            }
            result.push_back(s);
        }
        return result;
    }
};