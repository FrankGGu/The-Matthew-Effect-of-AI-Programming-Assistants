#include <iostream>
#include <vector>
#include <string>

using namespace std;

class Solution {
public:
    string finalString(string s) {
        string result;
        for (char c : s) {
            if (c == '#') {
                if (!result.empty()) {
                    result.pop_back();
                }
            } else {
                result.push_back(c);
            }
        }
        return result;
    }
};