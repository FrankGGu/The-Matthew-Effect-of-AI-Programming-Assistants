#include <iostream>
#include <vector>
#include <string>

using namespace std;

class Solution {
public:
    int countSubstrings(string s, string t) {
        int m = s.length();
        int n = t.length();
        int count = 0;

        for (int i = 0; i < m; ++i) {
            for (int j = 0; j < n; ++j) {
                int diff = 0;
                int k = 0;
                while (i + k < m && j + k < n) {
                    if (s[i + k] != t[j + k]) {
                        ++diff;
                    }
                    if (diff == 1) {
                        ++count;
                    } else if (diff > 1) {
                        break;
                    }
                    ++k;
                }
            }
        }

        return count;
    }
};