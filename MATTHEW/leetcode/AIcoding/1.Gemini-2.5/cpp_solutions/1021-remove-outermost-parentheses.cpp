#include <string>
#include <vector>

class Solution {
public:
    std::string removeOuterParentheses(std::string s) {
        std::string result = "";
        int balance = 0;
        for (char c : s) {
            if (c == '(') {
                if (balance > 0) {
                    result += c;
                }
                balance++;
            } else { // c == ')'
                balance--;
                if (balance > 0) {
                    result += c;
                }
            }
        }
        return result;
    }
};