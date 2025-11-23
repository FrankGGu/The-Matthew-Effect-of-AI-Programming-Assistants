class Solution {
public:
    string maskPII(string s) {
        if (s.find('@') != string::npos) {
            return maskEmail(s);
        } else {
            return maskPhone(s);
        }
    }

private:
    string maskEmail(string s) {
        string res;
        res += tolower(s[0]);
        res += "*****";
        size_t at_pos = s.find('@');
        res += tolower(s[at_pos - 1]);
        res += s.substr(at_pos);
        for (char &c : res) {
            if (isalpha(c)) {
                c = tolower(c);
            }
        }
        return res;
    }

    string maskPhone(string s) {
        string digits;
        for (char c : s) {
            if (isdigit(c)) {
                digits += c;
            }
        }
        string res;
        if (digits.size() > 10) {
            res += '+';
            res += string(digits.size() - 10, '*');
            res += '-';
        }
        res += "***-***-";
        res += digits.substr(digits.size() - 4);
        return res;
    }
};