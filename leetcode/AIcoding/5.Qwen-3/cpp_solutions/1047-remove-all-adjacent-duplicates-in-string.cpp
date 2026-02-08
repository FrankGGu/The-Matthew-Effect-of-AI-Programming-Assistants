#include <iostream>
#include <vector>
#include <string>

using namespace std;

class Solution {
public:
    string removeDuplicates(string s) {
        vector<char> stack;
        for (char c : s) {
            if (!stack.empty() && stack.back() == c) {
                stack.pop_back();
            } else {
                stack.push_back(c);
            }
        }
        return string(stack.begin(), stack.end());
    }
};