#include <iostream>
#include <vector>
#include <string>
#include <unordered_set>

using namespace std;

class Solution {
public:
    int distinctEchoSubstrings(string s) {
        int n = s.size();
        unordered_set<string> result;

        for (int i = 0; i < n; ++i) {
            for (int j = i + 1; j < n; ++j) {
                int len = j - i;
                if (j + len <= n) {
                    bool isEcho = true;
                    for (int k = 0; k < len; ++k) {
                        if (s[i + k] != s[j + k]) {
                            isEcho = false;
                            break;
                        }
                    }
                    if (isEcho) {
                        result.insert(s.substr(i, len));
                    }
                }
            }
        }

        return result.size();
    }
};