class Solution {
public:
    bool strongPasswordCheckerII(string password) {
        if (password.size() < 8) return false;
        bool hasLower = false, hasUpper = false, hasDigit = false, hasSpecial = false;
        string special = "!@#$%^&*()-+";
        for (int i = 0; i < password.size(); ++i) {
            if (i > 0 && password[i] == password[i-1]) return false;
            if (islower(password[i])) hasLower = true;
            else if (isupper(password[i])) hasUpper = true;
            else if (isdigit(password[i])) hasDigit = true;
            else if (special.find(password[i]) != string::npos) hasSpecial = true;
        }
        return hasLower && hasUpper && hasDigit && hasSpecial;
    }
};