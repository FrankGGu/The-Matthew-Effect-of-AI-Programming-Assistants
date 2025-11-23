#include <iostream>
#include <vector>
#include <string>
#include <algorithm>

using namespace std;

class Solution {
public:
    string lexSmallestString(string s) {
        int n = s.size();
        vector<char> chars(s.begin(), s.end());

        for (int i = 0; i < n; ++i) {
            if (chars[i] != '0') {
                for (int j = i; j < n; ++j) {
                    if (chars[j] == '0') {
                        break;
                    }
                    chars[j]--;
                }
                break;
            }
        }

        for (int i = n - 1; i >= 0; --i) {
            if (chars[i] != '0') {
                for (int j = i; j >= 0; --j) {
                    if (chars[j] == '0') {
                        break;
                    }
                    chars[j]--;
                }
                break;
            }
        }

        return string(chars.begin(), chars.end());
    }
};