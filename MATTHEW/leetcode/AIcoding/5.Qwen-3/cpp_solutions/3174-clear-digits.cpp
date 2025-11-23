#include <iostream>
#include <vector>
#include <string>

using namespace std;

class Solution {
public:
    string clearDigits(string s) {
        vector<char> stack;
        for (char c : s) {
            if (isdigit(c)) {
                if (!stack.empty() && isalpha(stack.back())) {
                    stack.pop_back();
                }
            } else {
                stack.push_back(c);
            }
        }
        return string(stack.begin(), stack.end());
    }
};