#include <string>
#include <algorithm>

using namespace std;

class Solution {
public:
    string reverseWords(string s) {
        string result = "";
        string word = "";
        for (int i = s.length() - 1; i >= 0; i--) {
            if (s[i] == ' ') {
                if (!word.empty()) {
                    if (!result.empty()) {
                        result += " ";
                    }
                    result += word;
                    word = "";
                }
            } else {
                word = s[i] + word;
            }
        }
        if (!word.empty()) {
            if (!result.empty()) {
                result += " ";
            }
            result += word;
        }
        return result;
    }
};