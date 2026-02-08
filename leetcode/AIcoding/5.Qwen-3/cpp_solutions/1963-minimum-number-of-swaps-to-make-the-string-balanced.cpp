#include <iostream>
#include <vector>
#include <string>

using namespace std;

class Solution {
public:
    int minSwapsToMakeBalanced(string s) {
        int open = 0;
        int close = 0;
        for (char c : s) {
            if (c == '[') {
                open++;
            } else {
                close++;
            }
            if (close > open) {
                open++;
                close--;
            }
        }
        return (open - close + 1) / 2;
    }
};