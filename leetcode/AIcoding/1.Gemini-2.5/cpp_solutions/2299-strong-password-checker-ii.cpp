class Solution {
public:
    bool strongPasswordCheckerII(std::string password) {
        if (password.length() < 8) {
            return false;
        }

        bool hasLower = false;
        bool hasUpper = false;
        bool hasDigit = false;
        bool hasSpecial = false;

        std::string specialChars = "!@#$%^&*()-+";

        for (int i = 0; i < password.length(); ++i) {
            char c = password[i];

            if (std::islower(c)) {
                hasLower = true;
            } else if (std::isupper(c)) {
                hasUpper = true;
            } else if (std::isdigit(c)) {
                hasDigit = true;
            } else {
                for (char sc : specialChars) {
                    if (c == sc) {
                        hasSpecial = true;
                        break;
                    }
                }
            }

            if (i > 0 && password[i] == password[i-1]) {
                return false;
            }
        }

        return hasLower && hasUpper && hasDigit && hasSpecial;
    }
};