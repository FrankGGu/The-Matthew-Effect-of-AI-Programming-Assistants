#include <iostream>
#include <string>
#include <vector>

using namespace std;

class Solution {
public:
    string removeOuterParentheses(string s) {
        string result;
        int balance = 0;
        for (char c : s) {
            if (c == '(') {
                balance++;
            }
            if (balance > 1) {
                result += c;
            }
            if (c == ')') {
                balance--;
            }
        }
        return result;
    }
};