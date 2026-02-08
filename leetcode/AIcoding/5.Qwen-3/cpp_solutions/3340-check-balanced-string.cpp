#include <iostream>
#include <vector>
#include <string>

using namespace std;

class Solution {
public:
    bool checkBalanced(string s) {
        int balance = 0;
        for (char c : s) {
            if (c == '(') {
                balance++;
            } else if (c == ')') {
                balance--;
                if (balance < 0) {
                    return false;
                }
            }
        }
        return balance == 0;
    }
};