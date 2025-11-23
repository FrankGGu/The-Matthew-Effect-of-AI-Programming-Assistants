#include <string>
#include <stack>
#include <cctype>

class Solution {
public:
    std::string decodeString(std::string s) {
        std::string currentString = "";
        std::stack<int> numStack;
        std::stack<std::string> strStack;
        int currentNum = 0;

        for (char c : s) {
            if (std::isdigit(c)) {
                currentNum = currentNum * 10 + (c - '0');
            } else if (std::isalpha(c)) {
                currentString += c;
            } else if (c == '[') {
                strStack.push(currentString);
                numStack.push(currentNum);
                currentString = "";
                currentNum = 0;
            } else if (c == ']') {
                int num = numStack.top();
                numStack.pop();
                std::string prevString = strStack.top();
                strStack.pop();

                std::string repeatedString = "";
                for (int i = 0; i < num; ++i) {
                    repeatedString += currentString;
                }
                currentString = prevString + repeatedString;
            }
        }
        return currentString;
    }
};