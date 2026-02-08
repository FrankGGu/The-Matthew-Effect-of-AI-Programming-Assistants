#include <string>

using namespace std;

class Solution {
public:
    bool strongPasswordCheckerII(string password) {
        if (password.length() < 8) return false;

        bool hasLower = false;
        bool hasUpper = false;
        bool hasDigit = false;
        bool hasSpecial = false;

        string specialChars = "!@#$%^&*()-+";

        for (char c : password) {
            if (islower(c)) hasLower = true;
            if (isupper(c)) hasUpper = true;
            if (isdigit(c)) hasDigit = true;
            if (specialChars.find(c) != string::npos) hasSpecial = true;
        }

        if (!hasLower || !hasUpper || !hasDigit || !hasSpecial) return false;

        for (int i = 0; i < password.length() - 1; ++i) {
            if (password[i] == password[i + 1]) return false;
        }

        return true;
    }
};