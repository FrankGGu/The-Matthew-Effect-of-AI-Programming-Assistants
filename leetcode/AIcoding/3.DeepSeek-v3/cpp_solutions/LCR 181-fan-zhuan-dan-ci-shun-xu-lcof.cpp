#include <algorithm>
#include <string>
using namespace std;

class Solution {
public:
    string reverseWords(string s) {
        string result = "";
        string temp = "";
        for (int i = 0; i < s.length(); i++) {
            if (s[i] != ' ') {
                temp += s[i];
            } else {
                if (!temp.empty()) {
                    reverse(temp.begin(), temp.end());
                    result += temp;
                    temp = "";
                }
                result += ' ';
            }
        }
        if (!temp.empty()) {
            reverse(temp.begin(), temp.end());
            result += temp;
        }
        return result;
    }
};