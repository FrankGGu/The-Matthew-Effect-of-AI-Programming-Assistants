class Solution {
public:
    string reformat(string s) {
        vector<char> digits;
        vector<char> letters;
        for (char c : s) {
            if (isdigit(c)) {
                digits.push_back(c);
            } else {
                letters.push_back(c);
            }
        }
        int diff = digits.size() - letters.size();
        if (abs(diff) > 1) {
            return "";
        }
        string res;
        bool digitFirst = digits.size() > letters.size();
        int i = 0, j = 0;
        while (i < digits.size() || j < letters.size()) {
            if (digitFirst) {
                if (i < digits.size()) {
                    res += digits[i++];
                }
                if (j < letters.size()) {
                    res += letters[j++];
                }
            } else {
                if (j < letters.size()) {
                    res += letters[j++];
                }
                if (i < digits.size()) {
                    res += digits[i++];
                }
            }
        }
        return res;
    }
};