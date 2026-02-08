class Solution {
public:
    bool strongPasswordChecker(string password) {
        int n = password.size();
        bool hasLower = false, hasUpper = false, hasDigit = false, hasSpecial = false;
        string specialChars = "!@#$%^&*()-+";

        for (char c : password) {
            if (islower(c)) hasLower = true;
            if (isupper(c)) hasUpper = true;
            if (isdigit(c)) hasDigit = true;
            if (specialChars.find(c) != string::npos) hasSpecial = true;
        }

        int requiredTypes = !hasLower + !hasUpper + !hasDigit + !hasSpecial;

        return n >= 8 && requiredTypes == 0;
    }
};