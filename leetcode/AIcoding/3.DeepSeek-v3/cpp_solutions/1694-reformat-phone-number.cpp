class Solution {
public:
    string reformatNumber(string number) {
        string digits;
        for (char c : number) {
            if (isdigit(c)) {
                digits += c;
            }
        }
        string res;
        int n = digits.size();
        int i = 0;
        while (i < n) {
            if (n - i > 4) {
                res += digits.substr(i, 3) + "-";
                i += 3;
            } else {
                if (n - i == 4) {
                    res += digits.substr(i, 2) + "-" + digits.substr(i + 2, 2);
                    i += 4;
                } else {
                    res += digits.substr(i, n - i);
                    i = n;
                }
            }
        }
        return res;
    }
};