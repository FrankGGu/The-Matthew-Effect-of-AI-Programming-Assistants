#include <iostream>
#include <vector>
#include <string>
#include <unordered_set>

using namespace std;

class Solution {
public:
    string longestNiceSubstring(string s) {
        int n = s.size();
        string result;

        for (int i = 0; i < n; ++i) {
            for (int j = i + 1; j <= n; ++j) {
                string sub = s.substr(i, j - i);
                bool isNice = true;
                for (char c : sub) {
                    if (sub.find(tolower(c)) == string::npos || sub.find(toupper(c)) == string::npos) {
                        isNice = false;
                        break;
                    }
                }
                if (isNice && sub.size() > result.size()) {
                    result = sub;
                }
            }
        }

        return result;
    }
};