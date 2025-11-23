#include <iostream>
#include <vector>
#include <string>
#include <algorithm>

using namespace std;

class Solution {
public:
    string pathEncryption(string s) {
        string result;
        for (char c : s) {
            if (c == ' ') continue;
            result += c;
        }
        return result;
    }
};