class Solution {
public:
    string maskPII(string s) {
        transform(s.begin(), s.end(), s.begin(), ::tolower);
        if (s.find('@') != string::npos) {
            // Email case
            auto pos = s.find('@');
            return s.substr(0, 1) + "*****" + s.substr(pos - 1, 1) + s.substr(pos);
        } else {
            // Phone case
            string digits;
            for (char c : s) {
                if (isdigit(c)) {
                    digits += c;
                }
            }
            string masked = "***-***-";
            if (digits.size() == 10) {
                masked += digits.substr(6);
            } else {
                masked = "+" + string(digits.size() - 10, '*') + "-***-***-" + digits.substr(digits.size() - 4);
            }
            return masked;
        }
    }
};