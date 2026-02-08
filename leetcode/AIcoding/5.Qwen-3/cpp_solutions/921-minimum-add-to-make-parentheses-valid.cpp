#include <iostream>
#include <string>
using namespace std;

class Solution {
public:
    int minAddToMakeValid(string s) {
        int balance = 0;
        int add = 0;
        for (char c : s) {
            if (c == '(') {
                balance++;
            } else {
                balance--;
                if (balance < 0) {
                    add++;
                    balance = 0;
                }
            }
        }
        return add + balance;
    }
};