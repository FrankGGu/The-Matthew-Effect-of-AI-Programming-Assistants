#include <string>

using namespace std;

class Solution {
public:
    string removeStars(string s) {
        string res = "";
        for (char c : s) {
            if (c == '*') {
                if (!res.empty()) {
                    res.pop_back();
                }
            } else {
                res += c;
            }
        }
        return res;
    }
};