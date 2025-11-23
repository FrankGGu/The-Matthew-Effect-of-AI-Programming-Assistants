#include <iostream>
#include <vector>
#include <string>

using namespace std;

class Solution {
public:
    string removeKDigits(string num, int k) {
        vector<char> stack;
        for (char c : num) {
            while (k > 0 && !stack.empty() && stack.back() > c) {
                stack.pop_back();
                k--;
            }
            stack.push_back(c);
        }

                while (k > 0) {
            stack.pop_back();
            k--;
        }

                string result;
        bool leadingZero = true;
        for (char c : stack) {
            if (c != '0') {
                leadingZero = false;
            }
            if (!leadingZero) {
                result.push_back(c);
            }
        }

        return result.empty() ? "0" : result;
    }
};