#include <iostream>
#include <vector>
#include <string>

using namespace std;

class Solution {
public:
    string minimizeStringValue(string s) {
        int n = s.length();
        vector<int> freq(26, 0);
        for (char c : s) {
            if (c != '?') {
                freq[c - 'a']++;
            }
        }

        for (int i = 0; i < n; ++i) {
            if (s[i] == '?') {
                for (int j = 0; j < 26; ++j) {
                    if (freq[j] > 0) {
                        s[i] = 'a' + j;
                        freq[j]--;
                        break;
                    }
                }
            }
        }

        return s;
    }
};