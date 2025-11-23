#include <string>
#include <stack>

using namespace std;

class Solution {
public:
    string decodeString(string s) {
        stack<int> numStack;
        stack<string> strStack;
        string res = "";
        int num = 0;

        for (char c : s) {
            if (isdigit(c)) {
                num = num * 10 + (c - '0');
            } else if (c == '[') {
                numStack.push(num);
                strStack.push(res);
                num = 0;
                res = "";
            } else if (c == ']') {
                int repeatTimes = numStack.top();
                numStack.pop();
                string prevStr = strStack.top();
                strStack.pop();
                string temp = "";
                for (int i = 0; i < repeatTimes; ++i) {
                    temp += res;
                }
                res = prevStr + temp;
            } else {
                res += c;
            }
        }

        return res;
    }
};