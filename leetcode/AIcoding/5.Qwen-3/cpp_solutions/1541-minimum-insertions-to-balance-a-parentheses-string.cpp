#include <iostream>
#include <string>
using namespace std;

class Solution {
public:
    int minInsertions(string s) {
        int res = 0, balance = 0;
        for (char c : s) {
            if (c == '(') {
                balance += 2;
                if (balance % 2 != 0) {
                    res++;
                    balance -= 1;
                }
            } else {
                balance--;
                if (balance < 0) {
                    res++;
                    balance += 2;
                }
            }
        }
        return res + balance;
    }
};