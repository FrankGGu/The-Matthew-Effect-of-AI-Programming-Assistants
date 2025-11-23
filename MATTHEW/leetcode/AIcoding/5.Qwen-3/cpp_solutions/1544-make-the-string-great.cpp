#include <iostream>
#include <vector>
#include <string>

using namespace std;

class Solution {
public:
    string makeGood(string s) {
        vector<char> stack;
        for (char c : s) {
            if (!stack.empty() && abs(c - stack.back()) == 32) {
                stack.pop_back();
            } else {
                stack.push_back(c);
            }
        }
        return string(stack.begin(), stack.end());
    }
};