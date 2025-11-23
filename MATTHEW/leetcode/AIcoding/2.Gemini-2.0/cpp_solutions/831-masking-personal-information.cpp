#include <string>

using namespace std;

class Solution {
public:
    string maskPII(string s) {
        size_t atPos = s.find('@');
        if (atPos != string::npos) {
            transform(s.begin(), s.end(), s.begin(), ::tolower);
            return string(1, s[0]) + "*****" + string(1, s[atPos - 1]) + "@" + s.substr(atPos + 1);
        } else {
            string digits = "";
            for (char c : s) {
                if (isdigit(c)) {
                    digits += c;
                }
            }
            string last4 = digits.substr(digits.length() - 4);
            string masked = "***-***-" + last4;
            if (digits.length() > 10) {
                string countryCode = "";
                for (int i = 0; i < digits.length() - 10; ++i) {
                    countryCode += "*";
                }
                masked = "+" + countryCode + "-" + masked;
            }
            return masked;
        }
    }
};