class Solution {
public:
    string reformat(string s) {
        string digits;
        string letters;

        for (char c : s) {
            if (isdigit(c)) {
                digits.push_back(c);
            } else {
                letters.push_back(c);
            }
        }

        int n_digits = digits.length();
        int n_letters = letters.length();

        if (abs(n_digits - n_letters) > 1) {
            return "";
        }

        string result = "";
        int p1 = 0;
        int p2 = 0;

        if (n_digits > n_letters) {
            // Digits start first
            while (p1 < n_digits || p2 < n_letters) {
                if (p1 < n_digits) {
                    result.push_back(digits[p1++]);
                }
                if (p2 < n_letters) {
                    result.push_back(letters[p2++]);
                }
            }
        } else if (n_letters > n_digits) {
            // Letters start first
            while (p1 < n_letters || p2 < n_digits) {
                if (p1 < n_letters) {
                    result.push_back(letters[p1++]);
                }
                if (p2 < n_digits) {
                    result.push_back(digits[p2++]);
                }
            }
        } else {
            // Equal number, either can start first. Let's say letters.
            while (p1 < n_letters || p2 < n_digits) {
                if (p1 < n_letters) {
                    result.push_back(letters[p1++]);
                }
                if (p2 < n_digits) {
                    result.push_back(digits[p2++]);
                }
            }
        }

        return result;
    }
};