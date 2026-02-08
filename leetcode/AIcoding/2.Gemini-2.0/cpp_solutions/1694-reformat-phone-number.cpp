#include <string>

using namespace std;

class Solution {
public:
    string reformatNumber(string number) {
        string digits = "";
        for (char c : number) {
            if (isdigit(c)) {
                digits += c;
            }
        }

        string result = "";
        int n = digits.length();
        int i = 0;

        while (n > 4) {
            result += digits.substr(i, 3) + "-";
            i += 3;
            n -= 3;
        }

        if (n == 4) {
            result += digits.substr(i, 2) + "-" + digits.substr(i + 2, 2);
        } else if (n == 3) {
            result += digits.substr(i, 3);
        } else if (n == 2) {
            result += digits.substr(i, 2);
        }

        return result;
    }
};