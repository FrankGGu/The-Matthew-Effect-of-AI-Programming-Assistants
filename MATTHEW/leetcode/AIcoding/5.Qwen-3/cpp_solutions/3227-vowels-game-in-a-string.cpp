#include <iostream>
#include <vector>
#include <string>

using namespace std;

class Solution {
public:
    bool canAliceWin(string s) {
        int vowels = 0;
        for (char c : s) {
            if (c == 'a' || c == 'e' || c == 'i' || c == 'o' || c == 'u') {
                vowels++;
            }
        }
        return vowels > 0;
    }
};