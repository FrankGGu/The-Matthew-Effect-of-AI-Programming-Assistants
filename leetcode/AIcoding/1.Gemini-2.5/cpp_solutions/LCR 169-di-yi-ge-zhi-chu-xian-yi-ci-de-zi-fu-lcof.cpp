#include <string>
#include <stack>
#include <cctype>

class Solution {
public:
    std::string decodeString(std::string s) {
        std::string currentString = "";
        std::stack<int> countStack;
        std::stack<std::string> stringStack;
        int k = 0;

        for (char ch : s) {
            if (std::isdigit(ch)) {
                k = k * 10 + (ch - '0');
            } else if (ch == '[') {
                countStack.push(k);
                stringStack.push(currentString);
                currentString = "";
                k = 0;
            } else if (ch == ']') {
                int repeatCount = countStack.top();
                countStack.pop();
                std::string prevString = stringStack.top();
                stringStack.pop();

                std::string repeatedPart = "";
                for (int i = 0; i < repeatCount; ++i) {
                    repeatedPart += currentString;
                }
                currentString = prevString + repeatedPart;
            } else { 
                currentString += ch;
            }
        }
        return currentString;
    }
};