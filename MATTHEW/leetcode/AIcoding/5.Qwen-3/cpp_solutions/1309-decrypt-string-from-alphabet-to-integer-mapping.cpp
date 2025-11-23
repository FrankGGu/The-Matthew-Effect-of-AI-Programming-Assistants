#include <iostream>
#include <string>
#include <vector>

using namespace std;

class Solution {
public:
    string freqAlphabets(string s) {
        string result;
        int i = 0;
        while (i < s.length()) {
            if (i + 2 < s.length() && s[i + 2] == '#') {
                int num = stoi(s.substr(i, 2));
                result += static_cast<char>('a' + num - 1);
                i += 3;
            } else {
                int num = s[i] - '0';
                result += static_cast<char>('a' + num - 1);
                i++;
            }
        }
        return result;
    }
};