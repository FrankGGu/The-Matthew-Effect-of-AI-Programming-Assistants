#include <iostream>
#include <string>
#include <vector>

using namespace std;

class Solution {
public:
    string reformatNumber(string number) {
        string digits;
        for (char c : number) {
            if (isdigit(c)) {
                digits.push_back(c);
            }
        }

        int n = digits.size();
        string result;
        int i = 0;

        while (i < n) {
            if (n - i > 4) {
                result += digits[i++];
                result += digits[i++];
                result += digits[i++];
                result += "-";
            } else if (n - i == 4) {
                result += digits[i++];
                result += digits[i++];
                result += "-";
                result += digits[i++];
                result += digits[i++];
            } else {
                result += digits[i++];
                if (i < n) {
                    result += digits[i++];
                }
            }
        }

        return result;
    }
};