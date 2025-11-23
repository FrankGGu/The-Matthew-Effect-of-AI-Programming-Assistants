#include <iostream>
#include <vector>
#include <string>

using namespace std;

class Solution {
public:
    vector<string> removeComments(vector<string>& source) {
        vector<string> result;
        bool inBlock = false;
        string line;

        for (const string& s : source) {
            for (int i = 0; i < s.length(); ++i) {
                if (inBlock) {
                    if (s[i] == '*' && i + 1 < s.length() && s[i + 1] == '/') {
                        inBlock = false;
                        ++i;
                    }
                } else {
                    if (s[i] == '/' && i + 1 < s.length()) {
                        if (s[i + 1] == '*') {
                            inBlock = true;
                            ++i;
                        } else if (s[i + 1] == '/') {
                            break;
                        }
                    } else {
                        line += s[i];
                    }
                }
            }
            if (!inBlock && !line.empty()) {
                result.push_back(line);
                line.clear();
            }
        }

        return result;
    }
};