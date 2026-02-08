#include <iostream>
#include <vector>
#include <string>

using namespace std;

class Solution {
public:
    string lexSmallestString(string s) {
        vector<char> stack;
        for (char c : s) {
            while (!stack.empty() && stack.back() > c) {
                stack.pop_back();
            }
            stack.push_back(c);
        }
        string result(stack.begin(), stack.end());
        return result;
    }
};