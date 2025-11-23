#include <iostream>
#include <vector>
#include <stack>
#include <string>
#include <cctype>

using namespace std;

class Solution {
public:
    string decodeString(string s) {
        stack<string> strStack;
        stack<int> numStack;
        string currentStr = "";
        int currentNum = 0;

        for (char ch : s) {
            if (isdigit(ch)) {
                currentNum = currentNum * 10 + (ch - '0');
            } else if (ch == '[') {
                strStack.push(currentStr);
                numStack.push(currentNum);
                currentStr = "";
                currentNum = 0;
            } else if (ch == ']') {
                int num = numStack.top();
                numStack.pop();
                string temp = currentStr;
                currentStr = strStack.top();
                strStack.pop();
                for (int i = 0; i < num; ++i) {
                    currentStr += temp;
                }
            } else {
                currentStr += ch;
            }
        }

        return currentStr;
    }
};