#include <iostream>
#include <string>
#include <vector>

using namespace std;

class Solution {
public:
    bool strongPasswordCheckerII(string password) {
        bool hasLower = false;
        bool hasUpper = false;
        bool hasDigit = false;
        bool hasSpecial = false;
        bool hasConsecutive = false;

        string specialChars = "!@#$%^&*()-+";

        for (int i = 0; i < password.length(); ++i) {
            if (islower(password[i])) hasLower = true;
            else if (isupper(password[i])) hasUpper = true;
            else if (isdigit(password[i])) hasDigit = true;
            else if (specialChars.find(password[i]) != string::npos) hasSpecial = true;

            if (i > 0 && password[i] == password[i - 1]) hasConsecutive = true;
        }

        return hasLower && hasUpper && hasDigit && hasSpecial && !hasConsecutive && password.length() >= 8;
    }
};