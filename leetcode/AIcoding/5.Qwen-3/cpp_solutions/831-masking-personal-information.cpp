#include <iostream>
#include <string>
#include <vector>

using namespace std;

class Solution {
public:
    string maskPII(string s) {
        string email = "";
        string phone = "";
        bool isEmail = false;

        for (char c : s) {
            if (c == '@') {
                isEmail = true;
                break;
            }
        }

        if (isEmail) {
            int atPos = s.find('@');
            string localPart = s.substr(0, atPos);
            string domain = s.substr(atPos + 1);
            return localPart[0] + "*****" + localPart.back() + "@" + domain;
        } else {
            string digits = "";
            for (char c : s) {
                if (isdigit(c)) {
                    digits += c;
                }
            }
            int n = digits.length();
            string areaCode = digits.substr(n - 10, 3);
            string middle = digits.substr(n - 7, 3);
            string lastFour = digits.substr(n - 4);
            return "(" + areaCode + ")" + "****" + lastFour;
        }
    }
};